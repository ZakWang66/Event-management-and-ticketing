class SessionController < ApplicationController
  skip_before_action :authorized, only: [:googleAuth, :verify_authenticity_token]
  def googleAuth
    # Get access tokens from the google server
    access_token = request.env["omniauth.auth"]
    user = User.from_omniauth(access_token)
    # Access_token is used to authenticate request made from the rails application to the google server
    user.google_token = access_token.credentials.token
    # Refresh_token to request new access_token
    # Note: Refresh_token is only sent once during the first request
    refresh_token = access_token.credentials.refresh_token
    user.google_refresh_token = refresh_token if refresh_token.present?
    user.save
    log_in(user)
    redirect_to root_path
  end

  def signOut
    session.delete(:user_id)
    redirect_to root_path
  end

  def signIn
    
  end

  def log_in user
    session[:user_id] = user.id
  end
end
