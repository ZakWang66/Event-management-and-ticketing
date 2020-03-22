class EventsController < ApplicationController
    skip_before_action :authorized, only: [:index]
    def index
        @booked_events = []
        participating_events = Participant.where(user_id:session[:current_user_id])
        participating_events.each { |x|
            @booked_events[x.event_id] = true
        }
        @events = Event.all
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
end
