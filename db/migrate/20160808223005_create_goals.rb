class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.string :name, null: false
      t.string :gstatus, null: false
      t.boolean :completed, null: false, default: false
      t.integer :user_id, null: false
      t.timestamps null: false
    end
  end
end
