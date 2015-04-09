Rails.application.routes.draw do

  get 'contact/new'

  post 'contact/create'

  resources :blogs, :path => "b" do
    resources :posts do
      resources :comments, :only => [:create]
    end
    resources :editors, only: [:index, :new, :create, :destroy]
  end
  
  match 'search' => 'blogs#search', :via => :get

  resources :ratings, only: :update
  devise_for :users, :controllers => { omniauth_callbacks: "users/omniauth_callbacks", registrations: "users/registrations" }

  resources :users do
    resources :users, only: [:index, :show, :edit]
    resources :follows, :only => [:create, :destroy]
  end
  mount Ckeditor::Engine => '/ckeditor'
  
  get 'home/index'
  get 'home/services'
  root 'home#index'
  match '*unmatched_route', :to => 'application#not_found', :via => :all

end
