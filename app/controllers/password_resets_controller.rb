class PasswordResetsController < ApplicationController
  # コントローラのアクションを実行する前に、get_userメソッドのeditとupdateアクションのみ実行する
  before_action :get_user,         only: [:edit, :update]
  # コントローラのアクションを実行する前に、valid_userメソッドのeditとupdateアクションのみ実行する
  before_action :valid_user,       only: [:edit, :update]
  # コントローラのアクションを実行する前に、check_expirationメソッドのeditとupdateアクションのみ実行する
  before_action :check_expiration, only: [:edit, :update]

  # 新規
  def new
  end

  # 作成
  def create
    # 変数にUserモデルのpassword_resetとemailを代入する
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    # 代入できた場合
    if @user
      # create_reset_digestメソッドを呼び出す
      @user.create_reset_digest
      # send_password_reset_emailを呼び出す
      @user.send_password_reset_email
      # フラッシュメッセージを表示する
      flash[:info] = "Email sent with password reset instructions"
      # rootページへリダイレクトする
      redirect_to root_url
    # 代入できなかった場合
    else
      # フラッシュメッセージを表示する
      flash.now[:danger] = "Email address not found"
      # newページへレンダリングする
      render 'new'
    end
  end

  # 編集
  def edit
  end

  # 更新
  def update
    # userとpasswordの値が空の場合
    if params[:user][:password].empty?
      # エラーメッセージを表示する
      @user.errors.add(:password, :blank)
      # editページへレンダリングする
      render 'edit'
    # userとpasswordの値が空ではない場合
    elsif @user.update_attributes(user_params)
      # loginする
      log_in @user
      # password再設定が成功したらダイジェストをnilにする
      @user.update_attribute(:reset_digest, nil)
      # フラッシュメッセージを表示する
      flash[:success] = "Password has been reset."
      # @userへリダイレクトする
      redirect_to @user
    # その他の場合
    else
      # editページへレンダリングする
      render 'edit'
    end
  end

  private

  # user_paramsアクション定義
  def user_params
    # paramsハッシュでは:user属性を必須とし、パスワード、パスワードの確認の属性をそれぞれ許可する
    params.require(:user).permit(:password, :password_confirmation)
  end

  # user情報を取得するメソッド
  def get_user
    # 変数にUserモデルのemailを代入する
    @user = User.find_by(email: params[:email])
  end

  # 正しいuserかどうか確認する
  def valid_user
    # 現在のuserでありuserが認証されない場合
    unless(@user && @user.activated? && @user.authenticated?(:reset, params[:id]))
    # rootページへリダイレクトする
    redirect_to root_url
    end
  end

  # トークンが期限切れかどうか確認する
  def check_expiration
    # パスワードの再設定の期限を設定している場合
    if @user.password_reset_expired?
      # フラッシュメッセージを表示する
      flash[:danger] = "Password reset has expired."
      # new_password_resetページへリダイレクトする
      redirect_to new_password_reset_url
    end
  end
end
