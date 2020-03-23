class IndexController < ApplicationController
    skip_before_action :authorized, only: [:home]

    def home
    end

    def show
        @user = User.find(params[:user_id])
    end
end
