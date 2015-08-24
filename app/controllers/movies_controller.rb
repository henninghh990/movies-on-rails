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
      does_exsist = Movie.where(:id => @movie.id).count

      if does_exsist == 0
        @film = Movie.new
        @film.id = @movie.id
        @film.title = @movie.title
        @film.poster = @movie.poster_path
        @film.runtime = @movie.runtime
        @film.imdb_id = @movie.imdb_id
        @film.overview = @movie.overview
        @film.release_date = @movie.release_date
        @film.original_language = @movie.original_language
        @film.tagline = @movie.tagline
        @film.poster_p = @movie.backdrop_path
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
        @film = Movie.find(@movie.id)
        if list_ids
            list_ids.each do |id|
              list = List.find(id)
              new_movielist = MovieList.new
              list.movie_lists << new_movielist
              @film.movie_lists << new_movielist
              new_movielist.save
        end
        flash[:notice] = "New exsisted, but was movie saved"
        redirect_to(:action => 'index')
      end
    end
    else
      flash[:notice] = "request post failed."
      redirect_to(:action => 'index')
    end
  end


end
