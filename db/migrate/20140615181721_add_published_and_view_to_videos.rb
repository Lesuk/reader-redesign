class AddPublishedAndViewToVideos < ActiveRecord::Migration
  def change
  	add_column :videos, :published_at, :datetime
  	add_column :videos, :views, :string
  end
end
