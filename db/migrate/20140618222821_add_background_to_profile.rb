class AddBackgroundToProfile < ActiveRecord::Migration
  def change
  	add_column :profiles, :background_pic, :string
  end
end
