class User < ApplicationRecord
    mount_uploader :portrait, PortraitUploader
    has_many :participants
    has_many :events, through: :participants

    scope :with_roles, -> (roles) {
        joins(:participants).merge(roles)
    }
    scope :with_organizers, -> { with_roles(Participant.organizer) }
    scope :with_co_organizers, -> { with_roles(Participant.co_organizer) }
    scope :with_audience, -> { with_roles(Participant.audience) }
    scope :with_visitors, -> { with_roles(Participant.visitor) }
end
