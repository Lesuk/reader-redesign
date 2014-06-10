class Comment < ActiveRecord::Base
	belongs_to :commentable, polymorphic: true
	belongs_to :user

	validates :body, presence: true
	#validate :article_should_be_published

	def article_should_be_published
		errors.add(:article_id, "is not publishe yet") if article && !article.published?
	end
end
