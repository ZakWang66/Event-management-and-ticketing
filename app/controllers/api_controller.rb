class ApiController < ApplicationController
  def getEvents
    events = Event.where(user: session[:user_id])
    curr = Time.now
    @past_events = []
    @future_events = []
    events.each do |event|
      if event.time < curr
        @past_events.append(event)
      else
        @future_evetns.append(event)
      end
    end
    
  end
end
