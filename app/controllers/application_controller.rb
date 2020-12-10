class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # Sessionsヘルパーを読み込む
  include SessionsHelper

  # 外部から使えないようにする
  private

  # userのloginを確認する
  def logged_in_user
    # loginをしていない場合
    unless logged_in?
      # アクセスしようとしたURLを覚えておくメソッド呼び出し
      store_location
      # フラッシュメッセージを表示する
      flash[:danger] = "Please log in."
      # loginページをリダイレクトする
      redirect_to login_in
    end
  end
end
