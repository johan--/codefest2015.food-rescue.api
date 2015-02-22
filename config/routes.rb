Rails.application.routes.draw do

  devise_for :users, controllers: {
    sessions: 'sessions',
    registrations: 'registrations'
  }, path: "api/v1/users"

  namespace :api do
    namespace :v1 do
      resources :zipcode, only: [:show]
      resources :users, only: [:update]
      resources :drivers, only: [:index, :update]
      resources :donors, only: [] do
        resources :donations, except: [:new, :edit] do
          member do
            get :start_donation
            get :verify_driver_to_donor_handshake
            get :verify_donor_to_recipient_handshake
            get :past_donations
          end
        end
      end
    end
  end
end
