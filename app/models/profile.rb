class Profile < ActiveRecord::Base
	belongs_to :user
	mount_uploader :background_pic, ProfileBackgroundUploader
end
