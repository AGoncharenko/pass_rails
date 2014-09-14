Rails.application.routes.draw do

  namespace :api do
    root 'boats#index'
    resources :boats, :only => [:index, :create]
    resources :timeslots, :only => [:index, :create]
    resources :assignments, :only => [:create]
    resources :bookings, :only => [:create]
  end
end
