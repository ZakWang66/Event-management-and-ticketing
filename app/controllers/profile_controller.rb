class ProfileController < ApplicationController
  skip_before_action :authorized, only: [:index]

  def index
  end

  def edit
  end

  def changePwd
  end

  def addFriend
  end
end
