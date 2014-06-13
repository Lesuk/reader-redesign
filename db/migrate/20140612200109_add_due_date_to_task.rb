class AddDueDateToTask < ActiveRecord::Migration
  def change
  	add_column :tasks, :due_date, :date
  	add_index :tasks, :due_date
  	add_index :tasks, :priority
  	add_index :tasks, :title
  end
end
