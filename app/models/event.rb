class Event < ApplicationRecord
    has_many :participants
    has_many :users, through: :participants

    has_many :pictures
    has_many :videos

    scope :with_roles, -> (roles) {
        joins(:participants).merge(roles)
    }
    scope :with_organizers, -> { with_roles(Participant.organizer) }
    scope :with_co_organizers, -> { with_roles(Participant.co_organizer) }
    scope :with_audience, -> { with_roles(Participant.audience) }
    scope :with_visitors, -> { with_roles(Participant.visitor) }
    
    scope :filter_by_price, -> (prices) {where("price > ? AND price <= ?", prices[0], prices[1])}

    def self.order_list(sort_order)
        if sort_order == "price"
            order(price: :desc)
        elsif sort_order == "date"
            order(time: :desc)
        else
            order(created_at: :asc)
        end
    end
end
