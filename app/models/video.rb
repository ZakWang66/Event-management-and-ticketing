class Video < ApplicationRecord
  mount_uploader :video, VideoUploader
  belongs_to :event
end
