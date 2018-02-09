class CreateRatings < ActiveRecord::Migration[5.1]
  def change
    create_table :ratings do |t|
      t.integer :rating_value
      t.text :comment
      t.references :film, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
