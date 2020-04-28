class FollowsController < ApplicationController
  before_action :correct_user?, only: [:create, :destroy]
  before_action :followee_exist?, only: [:create, :destroy]

  def create
    @user.follow(@followee)
    @user.save!
    redirect_to request.referer || root_path
  end

  def destroy
    @user.unfollow(@followee)
    @user.save!
    redirect_to request.referer || root_path
  end

  def getFollows
    @user = User.find(params[:user_id])
    @followers = @user.followers
    @followees = @user.followees
    render partial: "get_follows"
  end

  def userSearch
    @result = User
    name = params[:user][:name]
    if !name.nil?
        @result = @result.where("lower(name) like ?", "%#{name.downcase}%")
    end
    @result = @result.paginate(page: params[:page], per_page:5)
  end

  def followee_exist?
    @followee = User.find(params[:followee_id])
    if @followee.nil?
      flash[:danger] = "Didn't find the followee."
      redirect_to request.referer || root_path
    end
  end
end
