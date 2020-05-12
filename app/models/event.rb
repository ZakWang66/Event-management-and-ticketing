class Event < ApplicationRecord
    has_many_attached :images
    has_many :participants
    has_many :users, through: :participants

    has_many :pictures
    has_many :videos

    has_many :posts

    has_many :applications
    has_many :applicants, through: :applications, class_name: "User"

    scope :with_roles, -> (roles) {
        joins(:participants).merge(roles)
    }
    scope :with_organizers, -> { with_roles(Participant.organizer) }
    scope :with_co_organizers, -> { with_roles(Participant.co_organizer) }
    scope :with_audience, -> { with_roles(Participant.audience) }
    scope :with_visitors, -> { with_roles(Participant.visitor) }
    
    scope :filter_by_price, -> (prices) {where("price > ? AND price <= ?", prices[0], prices[1])}

    def self.order_list(sort_order)
        if sort_order == "price down"
            order(price: :desc)
        elsif sort_order == "price up"
            order(price: :asc)
        elsif sort_order == "newest"
            order(time: :desc)
        else
            order(time: :asc)
        end
    end

    def add_user(applicant)
        Participant.create(user: applicant, event_id: id, role: :audience)
    end

    paginates_per 24
end
