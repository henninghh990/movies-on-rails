class CreateMovieLists < ActiveRecord::Migration
  def change
    create_table :movie_lists do |t|
    	t.references :list
    	t.references :movie
    	t.string :comment
    	t.integer :rating	
      t.timestamps null: false
    end
    add_index :movie_lists, ["list_id", "movie_id"]
  end
end
