require "babosa"
class Article < ActiveRecord::Base
	extend FriendlyId
  	friendly_id :title, use: :slugged
	has_many :categorizes
	has_many :categories, through: :categorizes
	has_many :comments, as: :commentable
	has_many :postviews
	has_reputation :votes, source: :user, aggregated_by: :sum
	belongs_to :user
	after_save :add_index_to_art

	mount_uploader :thumbnail, ThumbnailUploader

	include Tire::Model::Search
    include Tire::Model::Callbacks

	default_scope -> {order('publish_date DESC')}
	scope :by_author, -> (user_id) { where user_id: user_id }
	scope :published, lambda { where("articles.publish_date IS NOT NULL AND articles.publish_date <= ?", Time.zone.now) }

	validates :title, :content, :user_id, presence: true

	def self.categorized_with(name)
		Category.find_by_name!(name).articles
	end

	def self.users_articles(user)
		User.find_by_login!(user).articles		
	end

	def self.category_counts
		Category.select("categories.*, count(categorizes.category_id) as count").
			joins(:categorizes).group("categorizes.category_id")
	end

	def category_list
		categories.map(&:name).join(", ")
	end

	def category_list=(names)
		self.categories = names.split(",").map do |n|
			Category.where(name: n.strip).first_or_create!
		end
	end

	def normalize_friendly_id(input)
	    input.to_s.to_slug.normalize(transliterations: :ukrainian).to_s
	end

	def published?
		publish_date.present?
	end

	def owned_by?(owner)
		return false unless owner.is_a?(User)
		user == owner
	end

	def add_index_to_art
		self.index.store self
	end

	def self.search(params)
		tire.search(load: true) do
			query { string params[:query], default_operator: "AND" } if params[:query].present?
			filter :range, publish_date: {lte: Time.zone.now}
			#sort { by :publish_date, 'desc' }
		end
	end

end
