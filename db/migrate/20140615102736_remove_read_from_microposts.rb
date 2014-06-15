class RemoveReadFromMicroposts < ActiveRecord::Migration
  def change
  	remove_column :messages, :read
  	add_column :messages, :read, :integer, default: 0
  end
end
