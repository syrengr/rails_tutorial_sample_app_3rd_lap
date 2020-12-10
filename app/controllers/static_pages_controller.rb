class StaticPagesController < ApplicationController

  # メソッド定義
  def home
    if logged_in?
      @micropost = current_user.microposts.build
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
