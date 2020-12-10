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
  # userを新規登録する
  get '/signup', to: 'users#new'
  # POSTリクエストが /signup に送信されたときにUsersコントローラのcreateアクションを呼び出す  
  post '/signup', to: 'users#create'
  # GETリクエストが /login に送信されたときにSessionsコントローラのnewアクションを呼び出す
  # userがアカウント情報を用いてネットに接続する
  get '/login', to: 'sessions#new'
  # GETリクエストが /login に送信されたときにSessionsコントローラのcreateアクションを呼び出す
  post '/login', to: 'sessions#create'
  # DELETEリクエストが /logout に送信されたときにSessionsコントローラのdestroyアクションを呼び出す
  delete '/logout', to: 'sessions#destroy'

  # HTTP標準を装備している
  resources :users do
    member do
      get :following, :followers
    end
  end

  # アカウント有効化に使うリソース
  resources :account_activations, only: [:edit]
  # password再設定用リソースを追加する
  resources :password_resets, only: [:new, :create, :edit, :update]
  # マイクロポストリソースのルーティング
  resources :microposts, only: [:create, :destroy]
  # Relationshipリソースのルーティング
  resources :relationships,       only: [:create, :destroy]
end
