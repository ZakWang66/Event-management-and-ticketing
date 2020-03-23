class ApplicationController < ActionController::Base
    before_action :authorized
    helper_method :current_user
    helper_method :logged_in?
    def current_user
        return unless session[:current_user_id]
        @current_user ||= User.find_by(id: session[:current_user_id])
    end

    def logged_in?
        !current_user.nil?
    end
    def authorized
        redirect_to root_path unless logged_in?
    end
end
