class ApiController < ApplicationController
  def getEvents
    user_id = params[:user_id]
    curr = Time.now
    @past_participants = Participant.where(user: user_id).joins(:event).where("events.time < ?", curr).order("events.time DESC")
    @future_participants = Participant.where(user: user_id).joins(:event).where("events.time >= ?", curr).order("events.time")
    render partial: "get_events"
  end
end
