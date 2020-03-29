class EventsController < ApplicationController
    skip_before_action :authorized, only: [:index]
    def index
        if params[:title]
            @event = Event.where("title LIKE ?", "%#{params[:title]}%")
        elsif params[:sort_by]
            @event = Event.order_list(params[:sort_by])
        elsif params[:filt_by]
            if params[:filt_by] == "more than 1000"
                @event = Event.where("price > ?", 1000)
            else
                conditions = params[:filt_by].split("-")
                @event = Event.filter_by_price(conditions)
            end
        else
            @event = Event.all
        end
    end

    
    def new
        @event = Event.new
        @pictures = []
        @title = "New Event"
    end

    def create
        e = Event.new(
            title:params[:title],
            price:params[:price],
            time: params[:time],
            place:params[:place],
            description:params[:description],
            created_at:Time.now.to_s
        )
        if e.save
            flash[:success] = "Event created successfully"
        else
            flash[:danger]  = "Some problem occours, event was not created"
        end
        redirect_to "/events"
    end

    def edit
        # authorized_to_edit(params[:id])
        @title = "Edit Event"
        @event = Event.find(params[:id])
        @pictures = Picture.where(event_id:params[:id])
    end

    def detail
    end

    def add_img
        # authorized_to_edit(params[:id])
        if params[:event].nil?
            flash[:danger] = "You need to choose a file"
        else
            p = Picture.create(event_id:params[:id])
            p.update(params.require(:event).permit(:picture))
            flash[:success] = "Image uploaded"
        end
        redirect_to "/events/#{params[:id]}/edit"
    end

    def delete_img
        p = Picture.find(params[:p_id])
        if p.nil?
            flash[:danger] = "No such picture"
        else
            flash[:success] = "Picture removed"
            p.destroy
        end
        redirect_to "/events/#{params[:id]}/edit"
    end

    def book
        if Participant.where(user_id:session[:current_user_id], event_id:params[:event_id]).empty?
            if Participant.create(user_id:session[:current_user_id], event_id:params[:event_id], role: :visitor)
                flash[:success] = "Thank you. You have successfully booked this event! user:#{session[:current_user_id]}, event#{params[:event_id]}"
            else
                flash[:danger] = "Some problem occoured user:#{session[:current_user_id]}, event:#{params["event_id"]}"
            end
        else
            flash[:danger] = "You cannot book that event again"
        end
        redirect_to events_path
    end

    private

    def authorized_to_edit(e_id)
        if session[:current_user_id] != Participant.where(event_id:e_id, role:1).first.user_id
            flash[:danger] = "You cannot edit this page."
            redirect_to '/events'
        end
    end
end
