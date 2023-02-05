Rails.application.routes.draw do
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

  # 会員側のルーティング設定
  # scope module: :public do
  #   get 'items' => 'items#index'
  # end

  # # 管理者側のルーティング設定
  # namespace :admin do
  # get 'items' => 'admin/items#index'
  # end


  scope module: :public do
    #scope module: :public do　URLは変えたくない、ファイル構成だけ指定のパスにしたい時に使用
    #ルーティングを"/"に設定した場合にはroot to:を使う
    root to: "homes#top"
    get "/about" => "homes#about", as: "about"
    #resourcesを使用するとnew,create,index,show,edit,update,destroyのルーティングが自動作成される。onlyでその中から絞ることが可能
    resources :items, only: [:index, :show]
    resources :registrations, only: [:new, :create]
    resources :sessions, only: [:new, :create, :destroy]
    resources :customers, only: [:show, :edit, :update]
    #only:で指定できないものは個別で記述
    get "/customers/unsubscribe" => "customers#unsubscribe"
    patch "/customers/withdraw" => "customers#withdraw"
    resources :cart_items, only: [:index, :update, :destroy,:create]
    delete "/cart_items/destroy_all" => "cart_items#destroy_all"
    resources :orders, only: [:new,:create, :index, :show]
    post "/orders/confirm" => "orders#comfirm"
    get "/orders/complete" => "orders#complete"
    resources :addresses
  end

  namespace :admin do
    #amespace :admin do　URLは指定のパスにしたい、ファイル構成も指定のパスにしたい時に使用
    resources :sessions, only: [:new, :create, :destroy]
    root to: "homes#top"
    resources :items
    resources :genres, only: [:index, :create, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:show, :update]
    resources :order_details, only: [:update]
  end

  end
