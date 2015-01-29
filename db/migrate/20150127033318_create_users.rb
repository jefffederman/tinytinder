class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :login
      t.string :gender
      t.string :gender_interest
      t.integer :age
      t.integer :age_interest_min
      t.integer :age_interest_max

      t.timestamps null: false
    end
  end
end
