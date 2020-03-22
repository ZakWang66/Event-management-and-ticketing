module ApiHelper
    def load_events(participants)
        tag = ""
        if participants.empty?
            tag += "Empty Event"
        else
            participants.each do |participant|
                event = participant.event
                tag += "
                <div class=\"card\">
                    <div class=\"card-body\">
                        <h4 class=\"card-title text-center\">#{event.title}</h4>
                        <p class=\"card-text\">Place: #{event.place}</p>
                        <p class=\"card-text\">Time: #{event.time}</p>
                        <p class=\"card-text\">Role: #{participant.role}</p>
                    </div>
                </div>"
            end
        end
        return tag.html_safe
    end
end
