class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.integer :user_id
      t.text :bio
      t.string :twitter
      t.string :youtube
      t.string :fb
      t.string :vk

      t.timestamps
    end
  end
end
