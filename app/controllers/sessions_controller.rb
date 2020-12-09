class SessionsController < ApplicationController
  # 新規
  def new
  end

  # 作成
  # 有効でないユーザーがログインすることのないようにする
  def create
    # downcaseメソッドを使って有効なemailが入力されたときに確実にマッチするように設定し、userをDBから見つけて検証する
    @user = User.find_by(email: params[:session][:email].downcase)
    # 現在のuserでありuserが認証された場合
    if @user && @user.authenticate(params[:session][:password])
      # userが有効の場合
      if @user.activated?
        # loginする
        log_in @user
        # params[:session][:remember_me]が'1'の場合はremember(@user)を返し、'1'ではない場合はforget(@user)を返す
        params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
        # @userをリダイレクトする
        redirect_back_or @user
      # userが無効の場合
      else
        # メッセージ定義
        message = "Account not activated."
        # 定義したメッセージに新たなメッセージを定義
        message += "Check your email for the activation link."
        # フラッシュメッセージを表示する
        flash[:warning] = message
        # rootページへリダイレクトする
        redirect_to root_url
      end
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
