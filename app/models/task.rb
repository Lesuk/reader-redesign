class Task < ActiveRecord::Base
	belongs_to :user

	scope :in_process, -> { where(completed: false) }
	scope :done, -> { where(completed: true) }
	scope :priority_order, -> {order("priority DESC")}

	validates :title, presence: true
end
