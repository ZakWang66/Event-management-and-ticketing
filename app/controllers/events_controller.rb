class EventsController < ApplicationController
    skip_before_action :authorized, only: [:index]
    def index
        @events = Event.all
        if params[:title]
            @events = @events.where("title LIKE ?", "%#{params[:title]}%")
        end

        if params[:sort_by]
            @events = @events.order_list(params[:sort_by])
        end

        if params[:filt_by]
            if params[:filt_by] == "more than 1000"
                @events = @events.where("price > ?", 1000)
            else
                conditions = params[:filt_by].split("-")
                @events = @events.filter_by_price(conditions)
            end
        end
        @events = @events.page(params[:page])
    end

    
    def new
        @url = "/events"
        @method = "post"
        @event = Event.new
        @pictures = []
        @title = "New Event"
    end

    def create
        puts params.inspect
        e = Event.new(
            title:params[:title],
            price:params[:price],
            time: params[:event][:time],
            place:params[:place],
            description:params[:description],
            created_at:Time.now.to_s
        )
        if e.save
            flash[:success] = "Event created successfully"
        else
            flash[:danger]  = "Some problem occours, event was not created"
        end
        Participant.create(user_id:session[:current_user_id], event_id:e.id, role: :organizer)
        redirect_to "/events"
    end

    def edit
        authorized_to_edit(params[:id])
        @url = "/events/#{params[:id]}"
        @method = "patch"
        @title = "Edit Event"
        @event = Event.find(params[:id])
    end

    def uploadImg
        @title = "Images"
        @event = Event.find(params[:id])
        @pictures = Picture.where(event_id:params[:id])
    end

    def update
        authorized_to_edit(params[:id])
        e = Event.find(params[:id])
        if e.nil?
            flash[:danger]  = "No such event"
        else
            e.update(
                title:params[:title],
                price:params[:price],
                time: params[:event][:time],
                place:params[:place],
                description:params[:description],
                created_at:Time.now.to_s
            )
            flash[:success]  = "Event updated"
        end
        redirect_to event_path(params[:id])
    end

    def show
        @event = Event.find(params[:id])
        @pictures = Picture.where(event_id:params[:id])
        @count = 0
        participant_relation = @event.participants.where(user_id:session[:current_user_id])
        @canApply = !is_expired_event(@event) && (participant_relation.empty? || participant_relation.first.role == "visitor" || participant_relation.first.role == "audience")
        @apply = @event.applications.where(user_id:session[:current_user_id])
        @apply = @apply.empty? ? nil : @apply.first
        @isBooked = !participant_relation.empty? && participant_relation.first.role == "audience"
        @liked = !participant_relation.empty? && (participant_relation.first.role == "visitor" || participant_relation.last.role == "visitor")
    end

    def like
        participant_relation = Participant.where(user_id:session[:current_user_id], event_id:params[:event_id])
        if !participant_relation.empty?
            flash[:danger] = "You have already booked this event"
        else
            Participant.create(user_id:session[:current_user_id], event_id:params[:event_id], role: :visitor)
            flash[:success] = "success!"
        end
        redirect_to "/events/#{params[:id]}"
    end

    def dislike
        participant_relation = Participant.where(user_id:session[:current_user_id], event_id:params[:event_id], role: :visitor)
        if participant_relation.empty?
            flash[:danger] = "You have not yet like this event"
        else
            participant_relation.each { |p|
                p.destroy
            }
            flash[:success] = "success!"
        end
        redirect_to "/events/#{params[:event_id]}"
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

    # def book
    #     role = Participant.where(user_id:session[:current_user_id], event_id:params[:event_id]).first
    #     if !is_expired_event(Event.find(params[:event_id])) && (role.nil? || role.role == "visitor")
    #         if Participant.create(user_id:session[:current_user_id], event_id:params[:event_id], role: :audience)
    #             if !role.nil?
    #                 role.destroy
    #             end
    #             flash[:success] = "Thank you. You have successfully applied to book this event!"
    #         else
    #             flash[:danger] = "Some problem occoured while trying to apply booking"
    #         end
    #     else
    #         flash[:danger] = "You cannot book that event"
    #     end
    #     redirect_to "/events/#{params[:event_id]}"
    # end

    # def cancel
    #     p = Participant.find_by(user_id:session[:current_user_id], event_id:params[:event_id], role: :audience)
    #     if is_expired_event(Event.find(params[:event_id])) || p.nil?
    #         flash[:danger] = "You cannot cancel"
    #     else
    #         p.destroy
    #         flash[:success] = "You have canceled your book"
    #     end
    #     redirect_to "/events/#{params[:event_id]}"
    # end

    private

    def authorized_to_edit(e_id)
        if Participant.where(event_id:e_id, role:1).nil? || session[:current_user_id] != Participant.where(event_id:e_id, role:1).first.user_id
            flash[:danger] = "You cannot edit this page."
            redirect_to "/events/#{e_id}"
        end
    end

    def is_expired_event(event)
        return event.time < Time.now
    end

end
