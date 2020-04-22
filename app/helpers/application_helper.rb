module ApplicationHelper
    def link_to_icon(url, icon_options, options={}, html_options=nil)
        options[:class] = ["btn hover-btn d-flex align-items-center", icon_options[:btn_class]]
        link_to(url, options, html_options) do
            content_tag(:span, icon_options[:text], class: "hover-text") +
            content_tag(:i, nil, class: [icon_options[:icon_class], "fa-lg hover-icon"]) +
            (content_tag(:i, nil, class: [icon_options[:icon_lock_class], "fa-lg hover-icon-lock"]) if icon_options[:icon_lock_class])
        end
    end

    def load_jpg
        content_tag(:div, nil, class: "text-center") do
            image_pack_tag("loading.gif", size: "100x100")
        end
    end

    def empty_placeholder(text)
        content_tag(:div, class: "text-center") do
            content_tag(:i, nil, class: "fas fa-lg fa-leaf text-success") +
            " " + text
        end
    end
end
