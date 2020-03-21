class Participant < ApplicationRecord
  belongs_to :user
  belongs_to :event
  enum role: { visitor: 0, organizer: 1, co_organizer: 2, audience: 3 }
end
