Rails.application.routes.draw do

  root to: 'static#index'

  resources :events do
    get 'checkin' => 'events#checkin'
    resources :attendees, only: [:index, :create]
    post 'import' => 'attendees#import'
  end
  resources :services
end
