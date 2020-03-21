class UsersController < ApplicationController
    skip_before_action :authorized, only: [:new, :create]
    def show
        @user = User.find(params[:id])
    end

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            flash[:success] = "Sign up succedd. Please sign in!"
            redirect_to sign_in_path
        else
            render 'new'
        end
    end

    private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
end
