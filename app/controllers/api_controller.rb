class ApiController < ApplicationController
  def getEvents
    user_id = params[:user_id]
    participants = Participant.where(user: user_id)
    curr = Time.now
    @past_participants = []
    @future_participants = []
    participants.each do |participant|
      if participant.event.time < curr
        @past_participants.append(participant)
      else
        @future_participants.append(participant)
      end
    end
    render partial: "get_events"
  end
end
