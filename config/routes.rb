Rails.application.routes.draw do

  devise_for :users, controllers: {
    sessions: 'sessions',
    registrations: 'registrations'
  }, path: "api/v1/users"

  namespace :api do
    namespace :v1 do
      resources :drivers, only: [:index, :update]
      resources :donors, only: [] do
        resources :donations, only: [:index, :create, :update]
      end
    end
  end
end
