class AccountActivationsController < ApplicationController
  # 編集用メソッドを定義する
  def edit
    # Userモデルのemailを取得する
    user = User.find_by(email: params[:email])
    # userが認証できている場合
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      # userモデルオブジェクト経由でアカウントを有効化する
      user.activate
      # loginする
      log_in user
      # フラッシュメッセージを表示する
      flash[:success] = "Account activated!"
      # userへリダイレクトする
      redirect_to user
    # user認証ができていない場合
    else
      # フラッシュメッセージを表示する
      flash[:danger] = "Invalid activation link"
      # rootページへリダイレクトする
      redirect_to root_url
    end
  end
end
