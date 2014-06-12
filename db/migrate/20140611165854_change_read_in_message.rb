class ChangeReadInMessage < ActiveRecord::Migration
  def change
  	change_column :messages, :read, :boolean
  end
end
