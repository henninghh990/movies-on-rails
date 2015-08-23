class MovieListsController < ApplicationController

	layout "application"

	def index
		
			@lists = current_user.lists.first
			@movies = @lists.movie_lists
		

	end

	def destroy
	    movie_list = MovieList.find(params[:id]).destroy
	    flash[:notice] = "Movie deleted successfully."
	    redirect_to(:controller => 'lists', :action => 'index')
  end
end
