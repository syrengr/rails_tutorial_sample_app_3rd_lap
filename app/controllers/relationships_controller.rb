class RelationshipsController < ApplicationController
  # コントローラのアクションを実行する前に、logged_in_userメソッドを実行する
  before_action :logged_in_user

  # 作成
  def create
    # 変数にUserモデルのfollowed_idを代入する
    @user = User.find(params[:followed_id])
    # 現在のuserのfollowを表示する
    current_user.follow(@user)
    # レスポンスを返す
    respond_to do |format|
      # htmlを返す
      format.html { redirect_to @user }
      # jsを返す
      format.js
    end
  end

  # 削除する
  def destroy
    # 変数にRelationshipモデルのidをfollowedと紐付けて代入する
    @user = Relationship.find(params[:id]).followed
    # 現在のuserのunfollowを表示する
    current_user.unfollow(@user)
    # レスポンスを返す
    respond_to do |format|
      # htmlを返す
      format.html { redirect_to @user }
      # jsを返す
      format.js
    end
  end
end
