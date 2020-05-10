module FollowsHelper
    def link_to_unfollow(follower_id, followee_id, type)
        icon_options = {
            btn_class: "btn-outline-danger", text: "Unfollow", icon_class: "fas fa-heart text-danger", icon_lock_class: "fas fa-user-slash"
        }
        link_to_icon follows_path(user_id: follower_id, followee_id: followee_id, type: type), icon_options, method: "delete", remote: true
    end

    def link_to_follow(follower_id, followee_id, type)
        icon_options = {
            btn_class: "btn-outline-primary", text: "Follow", icon_class: "far fa-heart text-danger", icon_lock_class: "fas fa-heart text-danger"
        }
        link_to_icon follows_path(user_id: follower_id, followee_id: followee_id, type: type), icon_options, method: "post", remote: true
    end

    def search_user
        content_tag(:div, nil, class: "d-flex justify-content-center h-100") do
            content_tag(:div, nil, class: "searchbar btn-outline-success") do
                form_for(:user, url: user_search_path, method: "get", remote: true) do |f|
                    f.text_field(:name, placeholder: "Search the name", class: "search_input flex-grow-1") +
                    content_tag(:button, type: "submit", class: "search_icon") do
                        content_tag(:i, nil, class: "fas fa-search")
                    end
                end
            end
        end
    end
end
