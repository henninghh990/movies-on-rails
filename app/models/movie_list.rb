class MovieList < ActiveRecord::Base
	belongs_to :list
	belongs_to :movie
end
