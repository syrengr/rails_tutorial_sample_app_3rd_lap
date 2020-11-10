Rails.application.routes.draw do
  # ルート「/」へのGETリクエストがStaticPagesコントローラのhomeアクションにルーティングされる
  root 'static_pages#home'
  # /static_pages/homeというURLに対するリクエストを、StaticPagesコントローラのhomeアクションと結びつけている
  get 'static_pages/home'
  # /static_pages/helpというURLに対するリクエストを、StaticPagesコントローラのhelpアクションと結びつけている
  get 'static_pages/help'
  # /static_pages/aboutというURLに対するリクエストを、StaticPagesコントローラのaboutアクションと結びつけている
  get 'static_pages/about'
  # /static_pages/contactというURLに対するリクエストを、StaticPagesコントローラのcontactアクションと結びつけている
  get 'static_pages/contact'
end
