Rails.application.routes.draw do

  namespace :api, defaults: { format: 'json' } do
    resources :blogs, :path => "b", :only => [:show]
    resources :posts, :only => [:show]
    resources :users, :only => [:index, :show]
  end

  resources :blogs, :path => "b" do
    resources :posts do
      resources :comments, :only => [:create]
    end
    resources :editors, only: [:index, :new, :create, :destroy]
  end
  
  resources :ratings, only: :update
  
  resources :users do
    resources :users, only: [:index, :show, :edit]
    resources :follows, :only => [:create, :destroy]
  end
  
  devise_for :users, :controllers => { 
            omniauth_callbacks: "users/omniauth_callbacks",
            registrations: "users/registrations" }
  
  mount Ckeditor::Engine => '/ckeditor'
  
  root 'home#index'
  get 'contact/new'
  get 'home/index'
  get 'home/services'
  post 'contact/create'
  match '*unmatched_route', :to => 'application#not_found', :via => :all
  match 'search' => 'blogs#search', :via => :get
end
