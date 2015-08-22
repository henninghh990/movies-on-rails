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
  	
  end
end
