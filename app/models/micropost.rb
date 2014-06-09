class Micropost < ActiveRecord::Base
	belongs_to :user
	default_scope -> {order('created_at DESC')}
	validates :user_id, presence: true
	validates :content, presence: true, length: {maximum: 140}
	has_many :comments, as: :commentable
	has_many :replies, foreign_key: "to_id", class_name: "Micropost"
	has_many :retweets, class_name: "Micropost", foreign_key: "retweet_id"
	has_reputation :mpost_likes, source: :user
	belongs_to :to, class_name: "User"
	before_save :check_in_reply_to_scan
	scope :from_users_followed_by_including_replies, -> (user) { followed_by_including_replies(user) }

	mount_uploader :mpost_picrute, MPicruteUploader

	@@reply_to_regexp = /@([A-Za-z0-9_]{1,15})/ #/\A@([^\s]*)/

	# Повертає мікропости від користувачів, за якими стежить даний користувач
	def self.from_users_followed_by(user)
		followed_user_ids = "SELECT followed_id FROM relationships WHERE follower_id = :user_id"
		where("user_id IN (#{followed_user_ids}) OR user_id = :user_id", user_id: user.id)
	end

	def self.followed_by_including_replies(user)
		followed_ids = "SELECT followed_id FROM relationships WHERE follower_id = :user_id"
		where("user_id IN (#{followed_ids}) OR user_id = :user_id OR to_id = :user_id", user_id: user.id )
	end

	def check_in_reply_to
		if match = @@reply_to_regexp.match(content)
			user = User.find_by_login(match[1].downcase)
			self.to = user if user
		end
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

	def retweet_by(retweeter)
		if self.user == retweeter
			"Sorry, you can't retweet your own micropost"
		elsif self.retweets.where(user_id: retweeter.id).present?
			"You already retweeted!"
		else
			retweeter.microposts.create(content: self.content, user_id: retweeter.id, 
				retweet_id: self.id, repost_author: self.user_id, mtitle: self.mtitle, 
				mpost_picrute: self.mpost_picrute)
			flash = "Succesfully retweeted!"
		end
	end

	def repost_count(post_id)
		Micropost.where(retweet_id: post_id).count
	end

end