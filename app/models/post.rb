class Post < ApplicationRecord
  belongs_to :event
  belongs_to :author, class_name: "User", foreign_key: "user_id"
  
  belongs_to :parent, class_name: "Post", optional: true

  has_many :replies, class_name: "Post", foreign_key: "parent_id"

  scope :with_roots, -> {
    where(parent: nil)
  }
end
