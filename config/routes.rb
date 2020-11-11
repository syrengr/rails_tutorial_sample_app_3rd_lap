Rails.application.routes.draw do
  # ルート「/」へのGETリクエストがStaticPagesコントローラのhomeアクションにルーティングされる
  root 'static_pages#home'
  # GETリクエストが /help に送信されたときにStaticPagesコントローラーのhelpアクションを呼び出す
  get '/help', to: 'static_pages#help'
  # GETリクエストが /about に送信されたときにStaticPagesコントローラーのaboutアクションを呼び出す
  get '/about', to: 'static_pages#about'
  # GETリクエストが /help に送信されたときにStaticPagesコントローラーのcontactアクションを呼び出す
  get '/contact', to: 'static_pages#contact'
end
