module SessionsHelper
  
  # 渡されたuserでloginする
  def log_in(user)
    # userのブラウザ内の一時cookiesに暗号化済みのuseridが自動で作成される
    session[:user_id] = user.id
  end

  # userのsessionを永続的にする
  def remember(user)
    # userをDBに保存する
    user.remember
    # useridと記憶トークンの永続cookiesを作成する
    cookies.permanent.signed[:user_id] = user.id
    # userの記憶トークンを作成する
    cookies.permanent[:remember_token] = user.remember_token
  end

  # 現在ログイン中のuserを返す（いる場合）
  def current_user
    # session[:user_id]が存在する場合の処理
    if (user_id = session[:user_id])
      # user_idを探して変数に代入する
      @current_user ||= User.find_by(id: user_id)
    # cookies.signed[:user_id]が存在する場合の処理
    elsif (user_id = cookies.signed[:user_id])
      # user_idを探して変数に代入する
      user = User.find_by(id: user_id)
      # userであり、cookies[:remember_token]を所持している場合の処理
      if user && user.authenticated?(cookies[:remember_token])
        # loginする
        log_in user
        # userを変数に代入する
        @current_user = user
      end
    end
  end

  # userがloginしていればtrue、その他ならfalseを返す
  def logged_in?
    # 否定演算子により、current_userがnilではないことを示す
    !current_user.nil?
  end

  # 現在のuserをlogoutする
  def log_out
    # sessionを削除する
    session.delete(:user_id)
    # 現在のuserがnilになる
    @current_user = nil
  end

  # 永続的sessionを破棄する
  def forget(user)
    # userを忘れるforgetメソッドを呼び出す
    user.forget
    # user_idのcookiesを削除する
    cookies.delete(:user_id)
    # remember_tokenのcookiesを削除する
    cookies.delete(:remember_token)
  end

  # 現在のuserをlogoutする
  def log_out
    # forgetヘルパーメソッドを使って現在のuserを呼び出す
    forget(current_user)
    # sessionを削除する
    session.delete(:user_id)
    # 変数内がnilであることを確認する
    @current_user = nil
  end  
end
