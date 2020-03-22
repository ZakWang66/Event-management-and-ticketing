Rails.application.routes.draw do
  root 'index#show'
  get 'sign_out', to: 'session#destroy'
  get 'auth/:provider/callback', to: 'session#googleAuth'
  get 'auth/failure', to: redirect('/')
  get 'sign_in', to: 'session#new'
  post 'log_in', to: 'session#create'
  get 'profile/edit'
  get 'profile/changePwd'
  get 'profile/addFriend'
  get 'profile/:id', to: 'profile#show', as: 'profile'
  get 'api/get_events', to: 'api#getEvents', as: 'get_events'
  get 'events', to: 'events#index'
  post 'events', to: 'events#book'
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
