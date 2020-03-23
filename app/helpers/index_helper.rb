module IndexHelper
    def has_edit_permission(current_user_id, user_id)
        if current_user_id == user_id
            link_to  "Edit profile", profile_path
        else
            ""
        end
    end
end
