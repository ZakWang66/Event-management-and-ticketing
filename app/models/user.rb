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

    has_many :followed_users, foreign_key: :follower_id, class_name: 'Follow'
    has_many :followees, through: :followed_users

    has_many :following_users, foreign_key: :followee_id, class_name: 'Follow'
    has_many :followers, through: :following_users

    has_many :applications
    has_many :applied_events, through: :applications, source: :event, class_name: "Event"

    paginates_per 5
    max_paginates_per 5

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

      # Follows a user.
    def follow(other_user)
        followees << other_user
    end

    # Unfollows a user.
    def unfollow(other_user)
        followees.delete(other_user)
    end

    # Returns true if the current user is following the other user.
    def following?(other_user)
        followees.include?(other_user)
    end

    # Apply for an event.
    def apply(event)
        applied_events << event
    end

    # Approve an application
    def approve(application)
        application.event.add_user(application.applicant)
        delete_application(application)
    end

    # Disapprove an application
    def disapprove(application)
        delete_application(application)
    end

    # Delete an application
    def delete_application(application)
        participant = Participant.where(user:application.applicant, event:application.event, participants: {role: :visitor})
        participant.destroy_all if participant
        application.destroy
    end
end
