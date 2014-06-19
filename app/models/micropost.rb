class Micropost < ActiveRecord::Base
	belongs_to :user
	default_scope -> {order('microposts.created_at DESC')}
	validates :user_id, presence: true
	validates :content, presence: true, length: {maximum: 140}
	has_many :comments, as: :commentable
	has_many :replies, foreign_key: "to_id", class_name: "Micropost"
	has_many :retweets, class_name: "Micropost", foreign_key: "retweet_id"
	has_many :favorites, as: :favorable
	has_many :fans, through: :favorites, source: :user
	has_reputation :mpost_likes, source: :user, dependent: :destroy
	belongs_to :to, class_name: "User"
	before_save :check_in_reply_to_scan
	before_save :check_yt_video
	before_save :check_media
	scope :from_users_followed_by_including_replies, -> (user) { followed_by_including_replies(user) }

	mount_uploader :mpost_picrute, MPicruteUploader

	@@reply_to_regexp = /@([A-Za-z0-9_]{1,15})/ #/\A@([^\s]*)/
	YOUTUBE_LINK_FORMAT = /\A.*(youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*/i

	# Повертає мікропости від користувачів, за якими стежить даний користувач
	def self.from_users_followed_by(user)
		followed_user_ids = "SELECT followed_id FROM relationships WHERE follower_id = :user_id"
		where("user_id IN (#{followed_user_ids}) OR user_id = :user_id", user_id: user.id)
	end

	def self.followed_by_including_replies(user)
		followed_ids = "SELECT followed_id FROM relationships WHERE follower_id = :user_id"
		where("user_id IN (#{followed_ids}) OR user_id = :user_id OR to_id = :user_id", user_id: user.id )
	end

	def check_in_reply_to_scan
		check_dog = content.scan(@@reply_to_regexp)
		if check_dog
			check_dog.each do |dog|
				user = User.find_by_login(dog)
				self.to = user if user
			end
			content.gsub!(@@reply_to_regexp, '<a href="users/\1">@\1</a>')
		end
	end

	def check_yt_video
		check = content.match(YOUTUBE_LINK_FORMAT)
		if check && check[2]
			id = check[2].first(11) 
		end
	    if id && id.to_s.length == 11
	    	self.video = id
	    end
	end

	def check_media
		if !self.mpost_picrute.blank? || !self.video.blank?
			self.media = true
		end
	end

	def retweet_by(retweeter)
		if self.user == retweeter
			"Sorry, you can't repost your own micropost"
		elsif self.retweets.where(user_id: retweeter.id).present?
			"You already reposted!"
		else
			retweeter.microposts.create(content: self.content, user_id: retweeter.id, 
				retweet_id: self.id, repost_author: self.user_id, mtitle: self.mtitle, 
				mpost_picrute: self.mpost_picrute, video: self.video, mlink: self.mlink)
			flash = "Succesfully retposted!"
		end
	end

	def repost_count(post_id)
		Micropost.where(retweet_id: post_id).size
	end

	def set_main_author
		User.find_by("id == ?", self.repost_author)
	end

	def original_mpost
		Micropost.find_by(id: self.retweet_id)
	end

end