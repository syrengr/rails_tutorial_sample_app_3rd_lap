class SessionsController < ApplicationController
  # 新規
  def new
  end

  # 作成
  def create
    # downcaseメソッドを使って有効なemailが入力されたときに確実にマッチするように設定し、userをDBから見つけて検証する
    user = User.find_by(email: params[:session][:email].downcase)
    # 現在のuserでありuserが認証された場合の処理
    if user && user.authenticate(params[:session][:password])
      # userのloginを行いセッションのcreateアクションを完了する
      log_in user
      # loginしてuserを保存する
      remember user
      # userのプロフィールページにリダイレクトする
      redirect_to user
    else
      # login失敗時の処理
      flash.now[:danger] = "Invalid email/password combination"
      # newページへレンダリングする
      render 'new'
    end
  end

  # 削除
  def destroy
    # 別のタブまたはウィンドウでlogin中の場合のみ、logoutする
    log_out if logged_in?
    # トップページへリダイレクトする
    redirect_to root_url
  end
end
