module ApiHelper
    def load_events(participants)
        tag = ""
        if participants.empty?
            tag += "Empty Event"
        else
            participants.each do |participant|
                get_bg_color(participant.role)
                event = participant.event
                tag += "
                <div class=\"card #{get_bg_color(participant.role)}\">
                    <div class=\"card-body\">
                        <h4 class=\"card-title text-center\">#{event.title}</h4>
                        <p class=\"card-text\">Place: #{event.place}</p>
                        <p class=\"card-text\">Time: #{event.time}</p>
                        <p class=\"card-text\">Role: #{participant.role}</p>
                        <form action=\"/events/#{event[:id]}\" method=\"get\">
                            <button type=\"submit\" class=\"btn btn-primary\">View</button>
                        </form>
                    </div>
                </div>"
            end
        end
        return tag.html_safe
    end

    private
    def get_bg_color(role)
        case Participant.roles[role]
        when 1 #orginizer
            "bg-danger"
        when 2 #co_orginizer
            "bg-primary"
        when 3 #audience
            "bg-success"
        when 0 #visitor
            "bg-secondary"
        end
    end
end
