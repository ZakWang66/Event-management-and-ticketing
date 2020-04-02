class AppliesController < ApplicationController
    before_action :correct_user?, only: [:create, :destroy, :getApplications]
    before_action :event_exist?, only: [:create, :destroy]
    before_action :application_exist?, only: [:destroy, :approve, :disapprove]
    before_action :has_approval_right?, only: [:approve, :disapprove]

    def create
        @user.apply(@event)
        redirect_to request.referer || root_path
    end

    def destroy
        @user.delete_application
        redirect_to request.referer || root_path
    end

    def approve
        current_user.approve(@application)
        redirect_to request.referer || root_path
    end

    def disapprove
        current_user.disapprove(@application)
        redirect_to request.referer || root_path
    end

    def getApplications
        @applications = Application.joins(:event).merge(@user.events.joins(:participants).merge(Participant.with_approve_right))
        render partial: "show_applications"
    end

    private

    def event_exist?
        @event = Event.find(params[:event_id])
        if @event.nil?
          flash[:danger] = "Didn't find the event."
          redirect_to request.referer || root_path
        end
    end

    def application_exist?
        @application = Application.find(params[:id])
        if @application.nil?
            flash[:danger] = "Didn't find the application."
            redirect_to request.referer || root_path
        end
    end

    def has_approval_right?
        if @application.event.participants.with_approve_right.where(user: current_user).first.nil?
            flash[:danger] = "Didn't have the right to approve or dissaprove the application."
            redirect_to request.referer || root_path
        end
    end
end
