Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :votes, only: [:create]
  get '/bed_and_breakfasts' => 'venues#index'
end
