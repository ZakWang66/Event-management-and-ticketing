class ProfileController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def edit
  end

  def changePwd
  end

  def addFriend
  end
end
