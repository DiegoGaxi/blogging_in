Rails.application.routes.draw do
  if Rails.env.development? || Rails.env.production?
    # mount Sidekiq::Web => '/sidekiq'
  end
  
  devise_for :users, controllers: {
    registrations: 'users/registrations', # This controller handles actions related to user sign-up and account management.
  }

  resources :landing, only: %i[index] do
    collection do
      get :blog
    end
  end

  namespace :admin do
    resources :users, only: %i[index show]
    resources :blogs, only: %i[index new create edit update destroy]
  end


  root to: 'landing#index'
  get '/admin', to: 'admin/users#index', as: :admin_root
  get '/blogger', to: 'admin/blogs#index', as: :blogger_root

  get '/:alias', to: 'blogger#show', as: :blogger_landing
  get '/:alias/blog', to: 'blogger#blog', as: :blogger_blog
end