class FollowsController < ApplicationController
  before_action :correct_user, only: [:create, :destroy]

  def create
    byebug
    @user.follow(@followee)
    @user.save!
    redirect_to request.referer
  end

  def destroy
    @user.unfollow(@followee)
    @user.save!
    redirect_to request.referer
  end

  def getFollows
    @user = User.find(params[:user_id])
    @followers = @user.followers
    @followees = @user.followees
    render partial: "get_follows"
  end

  def userSearch
    @result = User
    if !params[:name].nil?
        @result = @result.where("lower(name) like ?", "%#{params[:name].downcase}%")
    end
    @result = @result.paginate(page: params[:page], per_page:5)
  end

  def correct_user
    if current_user.id == params[:user_id].to_i
      @user =  current_user
      @followee = User.find(params[:followee_id])
    else
      redirect_to index_path(current_user.id)
    end
  end
end
