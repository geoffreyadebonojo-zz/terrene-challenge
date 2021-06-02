# config/routes.rb
Rails.application.routes.draw do
  namespace :v1 do
    resources :todos do
      resources :items
    end
  end

  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'
end
