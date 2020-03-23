class ApiController < ApplicationController
  def getEvents
    user_id = params[:user_id]
    curr = Time.now
    @past_participants = Participant.includes(:event).where(user: user_id).where("events.time < ?", curr).order("events.time DESC")
    @future_participants = Participant.includes(:event).where(user: user_id).where("events.time >= ?", curr).order("events.time")
    render partial: "get_events"
  end
end
