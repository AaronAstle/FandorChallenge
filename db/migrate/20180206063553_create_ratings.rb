class CreateRatings < ActiveRecord::Migration[5.1]
  def change
    create_table :ratings do |t|
      t.integer :rating
      t.text :comment
      t.references :film_id, foreign_key: true
      t.references :user_id

      t.timestamps
    end
  end
end
