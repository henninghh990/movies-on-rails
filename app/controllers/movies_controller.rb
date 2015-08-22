class MoviesController < ApplicationController

layout "template"
before_action :authenticate_user!
  def index
  	
  end

  def search
  	TMDB::API.api_key = "ce57411404742be5f5ae111fb347f20e"
  	@movies = TMDB::Movie.search(params[:q])
  	@lists = current_user.lists
  end

  def create

    if request.post?
      list_ids = params[:lists].collect {|id| id.to_i} if params[:lists]
      
      @movie = TMDB::Movie.id(params[:id])
      @film = Movie.new
      @film.title = @movie.title
      @film.poster = @movie.poster
      @film.runtime = @movie.runtime
      @film.tmdb_id = @movie.tmdb_id
      @film.imdb_id = @movie.imdb_id
      @film.overview = @movie.overview
      @film.release_date = @movie.release_date
      @film.original_language = @movie.original_language
      @film.tagline = @movie.tagline
      @film.vote_avarage = @movie.vote_average

      if @film.save
        if list_ids
          list_ids.each do |id|
            list = List.find(id)
            new_movielist = MovieList.new
            list.movie_lists << new_movielist
            @film.movie_lists << new_movielist
            new_movielist.save
          end
          flash[:notice] = "New movie saved"
          redirect_to(:action => 'index')
        else
          flash[:notice] = "Could not find list"
          redirect_to(:action => 'index')
        end
        
      else
        flash[:notice] = "<!@film.save>"
        redirect_to(:action => 'index')
      end
    else
      flash[:notice] = "request post failed."
      redirect_to(:action => 'index')
    end
  end


end
