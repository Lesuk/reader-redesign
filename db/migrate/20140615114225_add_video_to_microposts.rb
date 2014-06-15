class AddVideoToMicroposts < ActiveRecord::Migration
  def change
  	add_column :microposts, :video, :string
  end
end
