class SessionsController < ApplicationController
  def new
  end

  def create
    # downcaseメソッドを使って有効なemailが入力されたときに確実にマッチするように設定し、userをDBから見つけて検証する
    user = User.find_by(email: params[:session][:email].downcase)
    # 現在のuserでありuserが認証された場合の処理
    if user && user.authenticate(params[:session][:password])
      # userのloginを行いセッションのcreateアクションを完了する
      log_in user
      # userのプロフィールページにリダイレクトする
      redirect_to user
    else
      # login失敗時の処理
      flash.now[:danger] = "Invalid email/password combination"
      # newページへレンダリングする
      render 'new'
    end
  end

  def destroy
  end
end
