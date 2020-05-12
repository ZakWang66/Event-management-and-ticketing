class FollowsController < ApplicationController
  before_action :correct_user?, only: [:create, :destroy]
  before_action :followee_exist?, only: [:create, :destroy]

  def create
    @user.follow(@followee)
    @user.save!
    if params[:type] == "flip"
      render_result "change_to_unfollow"
    elsif params[:type] == "reload"
      render_result "reload_follows"
    end
  end

  def destroy
    @user.unfollow(@followee)
    @user.save!
    if params[:type] == "flip"
      render_result "change_to_follow"
    elsif params[:type] == "delete"
      render_result "delete_follows"
    elsif params[:type] == "reload"
      render_result "reload_follows"
    end
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
    @result = @result.page(params[:page])
  end

  def followee_exist?
    @followee = User.find(params[:followee_id])
    if @followee.nil?
      flash[:danger] = "Didn't find the followee."
      redirect_to request.referer || root_path
    end
  end
end
