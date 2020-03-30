class PostsController < ApplicationController
    before_action :correct_user, only: [:update, :destroy]

    def getForum
        @posts = Post.where(event_id: params[:event_id]).with_roots
        @event = Event.where(event_id: params[:event_id])
        render partial: "posts", object: @posts, locals: {depth: 0, id: ''}
    end

    def new
        @post = Post.new
        @post.event_id = params[:event_id]
        @post.user_id = params[:user_id]
        @post.parent_id = params[:parent_id]
        @post.title = "Re: " + Post.find(params[:parent_id]).title
    end

    def create
        if params[:commit] == 'Post'
            @post = Post.new(post_params)
            if @post.save
                flash[:success] = "Post successfully"
                redirect_to event_path(id: post_params[:event_id])
            else
                render 'new'
            end
        else
            redirect_to event_path(id: post_params[:event_id])
        end
    end

    def edit
        @post = Post.find(params[:id])
    end

    def update
        if params[:commit] == 'Save'
            if @post.update(post_params)
                flash[:success] = "Edit successfully"
                redirect_to event_path(id: @post.event_id)
            else
                render 'new'
            end
        else
            redirect_to event_path(id: @post.event_id)
        end
    end

    def destroy
        event_id = @post.event_id
        @post.destroy
        flash[:success] = "Post deleted"
        redirect_to event_path(id: event_id)
    end

    private

    def post_params
        params.require(:post).permit(:event_id, :user_id, :parent_id,
                                     :title, :content)
    end

    def correct_user
        @post = current_user.posts.find_by(id: params[:id])
        redirect_to root_url if @post.nil?
    end
end
