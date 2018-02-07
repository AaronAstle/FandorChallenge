class AddCreatedByToFilms < ActiveRecord::Migration[5.1]
  def change
    add_column :films, :created_by, :int
  end
end
