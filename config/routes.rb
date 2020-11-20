Rails.application.routes.draw do
  # ルート「/」へのGETリクエストがStaticPagesコントローラのhomeアクションにルーティングされる
  root 'static_pages#home'
  # GETリクエストが /help に送信されたときにStaticPagesコントローラのhelpアクションを呼び出す
  get '/help', to: 'static_pages#help'
  # GETリクエストが /about に送信されたときにStaticPagesコントローラのaboutアクションを呼び出す
  get '/about', to: 'static_pages#about'
  # GETリクエストが /help に送信されたときにStaticPagesコントローラのcontactアクションを呼び出す
  get '/contact', to: 'static_pages#contact'
  # GETリクエストが /signup に送信されたときにUsersコントローラのnewアクションを呼び出す
  get 'signup', to: 'users#new'
  # HTTP標準を装備している
  resources :users
end
