class AddMlinkToMicropost < ActiveRecord::Migration
  def change
  	add_column :microposts, :mlink, :string
  end
end
