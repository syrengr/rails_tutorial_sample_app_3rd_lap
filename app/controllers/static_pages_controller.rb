class StaticPagesController < ApplicationController

  # メソッド定義
  def home
    # loginをしている場合
    if logged_in?
      # 変数に現在のuserのmicropostsを代入する
      @micropost = current_user.microposts.build
      # 変数に現在のuserのfeedを代入する
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  # メソッド定義
  def help
  end

  # メソッド定義 
  def about
  end

  # メソッド定義
  def contact
  end
end
