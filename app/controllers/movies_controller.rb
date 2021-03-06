class MoviesController < ApplicationController

layout "template"
before_action :authenticate_user!, except: [:show]
  def index
    @movies = Movie.all
  end

  def show
    TMDB::API.api_key = "ce57411404742be5f5ae111fb347f20e"
    @movie = TMDB::Movie.id(params[:id])
    @background = @movie.backdrop
    if user_signed_in? 
      @lists = current_user.lists
    end

  end

  def search
    TMDB::API.api_key = "ce57411404742be5f5ae111fb347f20e"
    
      
        @movies = TMDB::Movie.advanced_search('release_date.gte' => Date.today-1.month,
                            'release_date.lte' => Date.today)# 'vote_average.gte' => params[:ex1], 'vote_average.lte' => params[:ex2])
        @tekst = Date.today-1.month
        @lists = current_user.lists
        @search_title = "Movies from #{Date.today-1.month} to #{Date.today}"
      

      #else
      if params[:title]
        @movies = TMDB::Movie.search(params[:q])
        @lists = current_user.lists
        @search_title = "Search result for #{params[:q]}"
        if @movies.blank?
          flash[:notice] = "No movies matches your search"
          flash[:class] = "alert-warning"
          redirect_to(:action => 'index')
        end
    end

    if params[:date]
      rate = params[:ex1].split(',')
      date = params[:ex2].split(',')
      @datelol = "From #{date[0]}-01-01, to #{date[1]}-21-31"
      @rate_from = rate[0]
      @rate_to = rate[1]
      #(params[:date_from])? date = params[:date_from]: date = DateTime.now 
      #date_from = date.to_a.sort.collect{|c| c[1]}.join("-")
      #(params[:date_to])? date = params[:date_to]: date = DateTime.now 
      #date_to = date.to_a.sort.collect{|c| c[1]}.join("-")
      @movies = TMDB::Movie.advanced_search('release_date.gte' => '#{date[0]}-01-01',
                            'release_date.lte' => '#{date[1]}-12-31', 'vote_average.gte' => rate[0], 'vote_average.lte' => rate[1])
      @search_title = "Advanced Search"
      @lists = current_user.lists
      if @movies.blank?
          flash[:notice] = "No movies matches your search"
          flash[:class] = "alert-warning"
          redirect_to(:action => 'index')
        end
    end

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
            flash[:class] = "alert-success"
            redirect_to(:action => 'index')
          else
            flash[:notice] = "Could not find list"
            flash[:class] = "alert-danger"
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
        flash[:class] = "alert-success"
        redirect_to(:action => 'index')
      end
    end
    else
      flash[:notice] = "request post failed."
      flash[:class] = "alert-danger"
      redirect_to(:action => 'index')
    end
  end


end
