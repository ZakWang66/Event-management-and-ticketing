module ApiHelper
    def load_events(participants)
        tag = ""
        if participants.empty?
            tag += "Empty Event"
        else
            participants.each do |participant|
                tag += load_event(participant)
            end
        end
        return tag.html_safe
    end

    private
    def get_text_color(role)
        case Participant.roles[role]
        when 1 #orginizer
            "text-danger"
        when 2 #co_orginizer
            "text-primary"
        when 3 #audience
            "text-success"
        when 0 #visitor
            "text-secondary"
        end
    end

    def load_event(participant)
        event = participant.event
        content_tag(:div, nil, class: "card bg-light mb-3") do
            link_to(event_path(id: event.id), class: "nounderline") do
                content_tag(:div, nil, class: "card-body") do
                    content_tag(:h4, event.title, class: "card-title text-center") +
                    content_tag(:hr, nil) + 
                    content_tag(:div, nil, class: "hover_img text-center") do
                        if Picture.where(event_id: event[:id]).empty?
                            image_pack_tag("poster#{event[:id] % 30 + 1}.jpg", height: "100px")
                        else
                            image_tag(Picture.where(event_id: event[:id]).first.picture.url, height: "100px")
                        end
                    end +
                    content_tag(:div, nil, class: "row") do
                        content_tag(:div, "Place: #{event.place}", class: "card-text col-4") +
                        content_tag(:div, "Time: #{event.time}", class: "card-text col-4") +
                        content_tag(:div, "Role: #{participant.role}", class: "card-text #{get_text_color participant.role} col-4")
                    end
                end
            end
        end
    end
end
