class ApplicationController < ActionController::Base
    before_action :authorized
    helper_method :current_user
    helper_method :logged_in?
    before_action :initialize_omniauth_state
    def current_user
        User.find_by(id: session[:user_id])
    end
    def logged_in?
        !current_user.nil?
    end
    def authorized
        redirect_to root_path unless logged_in?
    end
    
    protected

    def initialize_omniauth_state
        session['omniauth.state'] = response.headers['X-CSRF-Token'] = form_authenticity_token
    end
end
