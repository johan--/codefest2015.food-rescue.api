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
            post :start_donation
            post :verify_driver_to_donor_handshake
            post :verify_donor_to_recipient_handshake
          end

          collection do
            get :past_donations
          end
        end
      end
    end
  end
end
