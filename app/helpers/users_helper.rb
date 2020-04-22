module UsersHelper
    def gravatar_for(user)
        if user.portrait.file.nil?
            gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
            gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
        else
            gravatar_url = user.portrait.url
        end
        image_tag(gravatar_url, alt: user.name, class: "gravatar")
    end

    def link_to_user(user)
        link_to user.name, index_path(user_id: user.id)
    end
end
