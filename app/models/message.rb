class Message < ActiveRecord::Base
	belongs_to :user
	validates :body, :recepient_id, presence: true
	validates :subject, length: {minimum: 3, maximum: 40 }
	validates :body, length: {minimum: 3 }

	default_scope -> {order('created_at DESC')}
end
