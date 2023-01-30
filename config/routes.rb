Rails.application.routes.draw do
  root to: "homes#top"

  # # 顧客用
  # # URL /customers/sign_in ...
  # devise_for :customers, controllers: {
  # registrations: "public/registrations",
  # sessions: 'public/sessions'
  # }

  # # 管理者用
  # # URL /admin/sign_in ...
  # devise_for :admin, controllers: {
  # sessions: "admin/sessions"
  # }

  # skip オプションを使用し不要なルーティングを削除
  # 顧客用
  # URL /customers/sign_in ...
  devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
  }

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
  }
  end
