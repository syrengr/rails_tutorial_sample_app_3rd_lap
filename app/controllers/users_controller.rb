class UsersController < ApplicationController

  # showアクション定義
  def show
    # paramsでユーザーid読み出す
    @user = User.find(params[:id])
  end

  # newアクション定義
  def new
     # form_forの引数で必要となるUserオブジェクトの作成
    @user = User.new
  end

  # createアクション定義
  def create
    # Userオブジェクトの作成
    @user = User.new(user_params)
    # 保存に成功した場合の処理
    if @user.save
      # user登録中にloginする
      log_in @user
      # 保存に失敗した場合の処理
      # フラッシュメッセージを追加する
      flash[:success] = "Welcome to the Sapmle App!"
      # 新しく作成されたuserのプロフィールページにリダイレクトする
      redirect_to @user
    else
      # newをレンダリングさせる
      render 'new'
    end
  end

  # 外部から使えないようにする
  private

    # user_paramsアクション定義
    def user_params
      # paramsハッシュでは:user属性を必須とし、名前、メールアドレス、パスワード、パスワードの確認の属性をそれぞれ許可する
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
