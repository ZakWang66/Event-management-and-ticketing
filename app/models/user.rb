class User < ApplicationRecord
    before_save { self.email = email.downcase }
    validates :name, presence: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 },
    format: { with: VALID_EMAIL_REGEX },
    uniqueness: { case_sensitive: false }
    has_secure_password
    
    mount_uploader :portrait, PortraitUploader
    has_many :participants
    has_many :events, through: :participants

    has_many :posts

    scope :with_roles, -> (roles) {
        joins(:participants).merge(roles)
    }
    scope :with_organizers, -> { with_roles(Participant.organizer) }
    scope :with_co_organizers, -> { with_roles(Participant.co_organizer) }
    scope :with_audience, -> { with_roles(Participant.audience) }
    scope :with_visitors, -> { with_roles(Participant.visitor) }

    scope :get_user_dict, -> (user_ids) {
        dict = {}
        find(user_ids).each do |user|
            dict[user.id] = user
        end
        return dict
    }

    def self.from_omniauth(auth)
        # Creates a new user only if it doesn't exist
        where(email: auth.info.email.downcase).first_or_initialize do |user|
          user.name = auth.info.name
          user.email = auth.info.email
          user.password = "default_password"
          user.remote_portrait_url = auth.info.image
        end
    end
end
