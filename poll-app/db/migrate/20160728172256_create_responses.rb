class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.integer :respondent_id, null: false
      t.integer :choice_id, null: false
      t.timestamps null: false
    end

    add_index :responses, :respondent_id
    add_index :responses, :choice_id
  end
end
