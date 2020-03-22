module SessionHelper
    def log_in user
        session[:current_user_id] = user.id
    end

    def log_out
        session.delete(:current_user_id)
    end
end
