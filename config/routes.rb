Rails.application.routes.draw do
  root 'profile#index'
  get 'session/googleAuth'
  get 'session/signOut'
  get 'session/signIn'
  get 'api/get_events', to: 'api#getElemt'
  get 'profile/edit'
  get 'profile/changePwd'
  get 'profile/addFriend'
  get 'profile', to: 'profile#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
