Rails.application.routes.draw do
  get 'get_follows', to: 'follows#getFollows'
  get 'user_search', to: 'follows#userSearch'
  root 'index#home'
  get 'sign_out', to: 'session#destroy'
  get 'auth/:provider/callback', to: 'session#googleAuth'
  get 'auth/failure', to: redirect('/')
  get 'sign_in', to: 'session#new'
  post 'log_in', to: 'session#create'
  patch 'users/:id/update_portrait', to: 'users#updatePortrait', as: 'update_portrait'
  patch 'users/:id/update_pwd', to: 'users#updatePassword', as: 'update_pwd'
  get 'profile', to: 'profile#show'
  get 'api/get_events', to: 'api#getEvents', as: 'get_events'
  post 'events/:id/like', to: 'events#like', as: 'like_event'
  post 'events/:id/dislike', to: 'events#dislike', as: 'dislike_event'
  # post 'events/book', to: 'events#book', as: 'book_event'
  # post 'events/cancel', to: 'events#cancel', as: 'cancel_event'
  post 'events/picture/upload/:id', to: 'events#add_img'
  post 'events/picture/delete/:id/:p_id', to: 'events#delete_img'
  get 'get_forum', to: 'posts#getForum', as: 'get_forum'
  resources :users
  resources :events
  resources :posts
  resources :applies, path: :applications, only: [:create, :destroy], as: "edit_apply"
  post 'follows', to: 'follows#create'
  delete 'follows', to: 'follows#destroy'
  post 'applications/:id/approve', to: 'applies#approve', as: 'application_approve'
  post 'applications/:id/disapprove', to: 'applies#disapprove', as: 'application_disapprove'
  get 'get_applications', to: 'applies#getApplications', as: 'get_applications'
  get ':user_id', to: 'index#show', as: 'index'
  get '/events/:id/uploadImg', to:'events#uploadImg'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
