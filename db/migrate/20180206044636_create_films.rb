class CreateFilms < ActiveRecord::Migration[5.1]
  def change
    create_table :films do |t|
      t.string :title
      t.text :description
      t.string :url_slug
      t.string :year

      t.timestamps
    end
  end
end
