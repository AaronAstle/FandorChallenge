class AddRelatedFilmsToFilm < ActiveRecord::Migration[5.1]
  def change
    add_column :films, :related_film_ids, :text, array: true
  end
end
