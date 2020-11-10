Rails.application.routes.draw do
  # /static_pages/homeというURLに対するリクエストを、StaticPagesコントローラのhomeアクションと結びつけている
  get 'static_pages/home'
  # /static_pages/helpというURLに対するリクエストを、StaticPagesコントローラのhelpアクションと結びつけている
  get 'static_pages/help'
  get 'static_pages/about'
  root 'application#hello'
end
