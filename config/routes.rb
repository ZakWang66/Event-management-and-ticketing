Rails.application.routes.draw do
  root 'profile#index'
  get 'sign_out', to: 'session#signOut'
  get 'auth/:provider/callback', to: 'session#googleAuth'
  get 'auth/failure', to: redirect('/')
  get 'session/signIn'
  get 'api/get_events', to: 'api#getElemt'
  get 'profile/edit'
  get 'profile/changePwd'
  get 'profile/addFriend'
  get 'profile', to: 'profile#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
