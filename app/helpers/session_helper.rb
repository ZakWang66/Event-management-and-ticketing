module SessionHelper
    def log_in user
        session[:current_user_id] = user.id
    end

    def log_out(current_user)
        session.delete(:current_user_id)
        current_user = nil
    end
end
