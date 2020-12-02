class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # Sessionsヘルパーを読み込む
  include SessionsHelper

  def hello
    render html: "hello, world"
  end
end
