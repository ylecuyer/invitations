Rails.application.routes.draw do

  root to: 'static#index'

  resources :events do
    get 'checkin' => 'events#checkin'
    resources :attendees, only: [:index, :create]
    resources :imports, only: :show do
      resources :import_attendees, only: [:edit, :update, :destroy]
      post 'terminate' => 'imports#terminate'
    end
    post 'import' => 'attendees#import'
  end
  resources :services
end
