class MovieListsController < ApplicationController

	layout "application"

	def index
		
			@lists = current_user.lists.first
			@movies = @lists.movie_lists
		

	end
end
