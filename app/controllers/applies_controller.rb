class AppliesController < ApplicationController
    before_action :correct_user?, only: [:create, :destroy, :getApplications]
    before_action :event_exist?, only: [:create, :destroy]
    before_action :application_exist?, only: [:destroy, :approve, :disapprove]
    before_action :has_approval_right?, only: [:approve, :disapprove]

    def create
        @user.apply(@event)
        render_result "delete_application_record"
    end

    def destroy
        @user.delete_application
        render_result "delete_application_record"
    end

    def approve
        @user = current_user
        @user.approve(@application)
        render_result "reload_applications"
    end

    def disapprove
        @user = current_user
        @user.disapprove(@application)
        render_result "reload_applications"
    end

    def getApplications
        @applications = Application.joins(:event).merge(@user.events.merge(Participant.with_approve_right))
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
            flash[:danger] = "Didn't find the application. This may due to wrong api usage or this application has been operated by others"
            redirect_to request.referer || root_path
        end
    end

    def has_approval_right?
        if @application.event.participants.with_approve_right.where(user: current_user).count == 0
            flash[:danger] = "Didn't have the right to approve or dissaprove the application."
            redirect_to request.referer || root_path
        end
    end

    def render_result filename
        respond_to do |f|
            f.html { redirect_to request.referer || root_path }
            f.js { render filename }
        end
    end
end
