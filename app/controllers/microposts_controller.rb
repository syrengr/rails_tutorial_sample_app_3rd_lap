class MicropostsController < ApplicationController
  # コントローラのアクションを実行する前に、logged_in_userメソッドのcreateとdestroyアクションのみ実行する
  before_action :logged_in_user, only: [:create, :destroy]
  # コントローラのアクションを実行する前に、
  before_action :correct_user, only: :destroy

  # 作成
  def create
    # 変数にmicropostsを代入する
    @micropost = current_user.microposts.build(micropost_params)
    # 変数を保存できた場合
    if @micropost.save
      # フラッシュメッセージを代入する
      flash[:success] = "Micropost created!"
      # rootページへリダイレクトする
      redirect_to root_url
    # 変数を保存できなかった場合
    else
      # 空のインスタンス変数を追加する
      @feed_items = []
      # 'static_pages/home'へレンダリングする
      render 'static_pages/home'
    end
  end

  # 削除
  def destroy
    # 変数内の値を削除する
    @micropost.destroy
    # フラッシュメッセージを表示する
    flash[:success] = "Micropost deleted"
    # リクエストかrootページをリダイレクトする
    redirect_to request.referrer || root_url
  end

  # 外部から使えないようにする
  private

  # micropost_paramsアクション定義
  def micropost_params
    # paramsハッシュでは:micropost属性を必須とし、contentの属性をそれぞれ許可する
    params.require(:micropost).permit(:content, :picture)
  end

  # correct_userアクション定義
  def correct_user
    # 変数に現在のuserのmicropostsを代入する
    @micropost = current_user.microposts.find_by(id: params[:id])
    # @micropostの値がnilであれば、rootページをリダイレクトする
    redirect_to root_url if @micropost.nil?
  end
end
