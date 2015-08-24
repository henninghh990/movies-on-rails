class MovieListsController < ApplicationController

	layout false

	def index

		
		if user_signed_in?
			@username = current_user.username
			@all_lists = current_user.lists
			
			@chosen_list = current_user.lists.first
				@movies = @chosen_list.movie_lists
				
			
		end
		if params[:username]
			@user = User.find_by_username(params[:username])
			if @user.nil?
				flash[:notice] = "No such user."
				redirect_to(:action => 'welcome')
			else
				@all_lists = @user.lists
				@chosen_list = @user.lists.first
				@movies = @chosen_list.movie_lists
				@username = @user.username
			end
			
		end
		if params[:list]
			@chosen_list = List.find(params[:list])
			@movies = @chosen_list.movie_lists
			@username = @user.username

		end
		if !user_signed_in? & !params[:username]
			render('welcome')
		end


	end

	def destroy
	    movie_list = MovieList.find(params[:id]).destroy
	    flash[:notice] = "Movie deleted successfully."
	    redirect_to(:controller => 'lists', :action => 'index')
  end


end
