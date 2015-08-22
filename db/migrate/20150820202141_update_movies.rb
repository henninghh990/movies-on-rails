class UpdateMovies < ActiveRecord::Migration
  def change
  	rename_column("movies", "length", "runtime")
  	add_column :movies, :release_date, :date
  	add_column :movies, :tmdb_id, :string
  	add_column :movies, :imdb_id, :string
  	add_column :movies, :overview, :string
  	add_column :movies, :original_language, :string
  	add_column :movies, :poster_p, :string
  	add_column :movies, :tagline, :string
  	add_column :movies, :vote_avarage, :float
  end
end
