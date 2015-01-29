class CreateRejects < ActiveRecord::Migration
  def change
    create_table :rejects do |t|
      t.integer :user_id
      t.integer :reject_id

      t.timestamps null: false
    end
  end
end
