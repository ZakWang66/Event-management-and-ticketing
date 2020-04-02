module AppliesHelper
    def link_to_approve_remote(application_id, operator_id)
        icon_options = {
            btn_class: "btn-outline-success", text: "Approve", icon_class: "fas fa-check text-success"
        }
        link_to_icon application_approve_path(id: application_id, user_id: operator_id), icon_options, method: "post", remote: true
    end

    def link_to_disapprove_remote(application_id, operator_id)
        icon_options = {
            btn_class: "btn-outline-danger", text: "Disapprove", icon_class: "fas fa-times text-danger"
        }
        link_to_icon application_disapprove_path(id: application_id, user_id: operator_id), icon_options, method: "post" ,remote: true
    end
end
