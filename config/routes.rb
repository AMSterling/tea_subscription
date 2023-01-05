Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :customers, only: %i[index show] do
        get '/subscriptions', to: 'customer_subscriptions#index'
      end
      resources :subscriptions, only: %i[create update]
    end
  end
end
