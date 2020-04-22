class Application < ApplicationRecord
  belongs_to :event
  belongs_to :applicant, class_name: "User", foreign_key: "user_id"
end
