class UsersController < ApplicationController
  # コントローラのアクションを実行する前に、logged_in_userメソッドのeditとupdateアクションのみ実行する
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy, :following, :followers]
  # コントローラのアクションを実行する前に、currect_userメソッドのeditとupdateアクションのみ実行する
  before_action :correct_user, only: [:edit, :update]
  # destroyアクションを管理者だけに限定する
  before_action :admin_user, only: :destroy

  # userの一覧ページ
  def index
    # Usersをページネートする
    @users = User.where(activated: true).paginate(page: params[:page])
  end

  # showアクション定義
  def show
    # paramsでユーザーid読み出す
    @user = User.find(params[:id])
    # 有効なuserだけを表示する
    @microposts = @user.microposts.paginate(page: params[:page])
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
      # userモデルオブジェクトからメールを送信する
      @user.send_activation_email
      # フラッシュメッセージを表示する
      flash[:info] = "Please check your email to activate your account."
      # rootページへリダイレクトする
      redirect_to root_url
    else
      # newをレンダリングさせる
      render 'new'
    end
  end

  # editアクション定義
  def edit
    # Userモデルのidを検索して変数に代入する
    @user = User.find(params[:id])
  end

  # updateアクション定義
  def update
    # Userモデルのidを検索して変数に代入する
    @user = User.find(params[:id])
    # 更新に成功した場合の処理
    if @user.update_attributes(user_params)
      # 成功用のフラッシュメッセージを表示する
      flash[:success] = "Profile updated"
      # Userモデルのidページを表示する
      redirect_to @user
    # 更新に失敗した場合の処理
    else
      # editページへレンダリングする
      render 'edit'
    end
  end

  # destroyアクション定義
  def destroy
    # Userモデルのidを検出し削除する
    User.find(params[:id]).destroy
    # フラッシュメッセージを表示する
    flash[:success] = "User deleted"
    # usersページへリダイレクトする
    redirect_to users_url
  end

  # followingアクション定義
  def following
    # 変数に"Following"を代入する
    @title = "Following"
    # 変数にUserモデルのidを代入する
    @user  = User.find(params[:id])
    # 変数にfollowingを代入する
    @users = @user.following.paginate(page: params[:page])
    # 'show_follow'をレンダリングする
    render 'show_follow'
  end

  # followersアクション定義
  def followers
    # 変数に"Followers"を代入する
    @title = "Followers"
    # 変数にUserモデルのidを代入する
    @user  = User.find(params[:id])
    # 変数にfollowersを代入する
    @users = @user.followers.paginate(page: params[:page])
    # 'show_follow'をレンダリングする
    render 'show_follow'
  end

  # 外部から使えないようにする
  private

  # user_paramsアクション定義
  def user_params
    # paramsハッシュでは:user属性を必須とし、名前、メールアドレス、パスワード、パスワードの確認の属性をそれぞれ許可する
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  # beforeアクション

  # 正しいuserかどうか確認する
  def correct_user
    # Userモデルのidを検索して変数に代入する
    @user = User.find(params[:id])
    # @userが現在のuserではなければ、rootページへリダイレクトする
    redirect_to(root_url) unless current_user?(@user)
  end

  # 管理者かどうか確認する
  def admin_user
    # rootページへリダイレクトする
    redirect_to(root_url) unless current_user.admin?
  end
end
