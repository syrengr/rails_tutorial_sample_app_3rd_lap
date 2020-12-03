module SessionsHelper
  
  # 渡されたuserでloginする
  def log_in(user)
    # userのブラウザ内の一時cookiesに暗号化済みのuseridが自動で作成される
    session[:user_id] = user.id
  end

  # 現在ログイン中のuserを返す（いる場合）
  def current_user
    # sessionに含まれる現在のuserを検索する
    if session[:user_id]
      # 現在のuserを検索して変数に代入する
      # 代入演算子||=により、変数内のnilではなく現在のuser情報が代入されるため、nilを省いていると解釈できる
      @current_user ||= User.find_by(id: session[:user_id])
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
end
