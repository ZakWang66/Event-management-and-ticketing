class UsersController < ApplicationController
    skip_before_action :authorized, only: [:new, :create]
    require_relative '../forms/change_password_form'

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
            redirect_to root_path
            # render 'new'
        end
    end

    def edit
        @user = current_user
    end

    def editPassword
    end

    def update
        @user = current_user
        if params[:commit] == 'Save'
            if @user.update(user_params)
                flash[:success] = "Edit success"
                redirect_to profile_path
            else
                render 'edit'
            end
        end
    end

    def updatePassword
        
        @pass_form = ChangePasswordForm.new(current_user)
        if @pass_form.submit(params[:pass_form])
            flash[:success] = "Edit success"
        else
            flash[:danger] = "Edit fails"
        end
        redirect_to profile_path
    end

    private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation, :portrait)
    end
end
