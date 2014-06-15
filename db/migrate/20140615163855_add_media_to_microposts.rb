class AddMediaToMicroposts < ActiveRecord::Migration
  def change
  	add_column :microposts, :media, :boolean, default: false
  	add_index :microposts, :media
  end
end
