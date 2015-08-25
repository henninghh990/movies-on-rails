class ListsController < ApplicationController

  layout 'template'

  before_action :authenticate_user!

  def index
    @lists = current_user.lists
  end

  def show
    @list = List.find(params[:id])
    @movies = @list.movie_lists
  end

  def new
    @list = List.new({:user_id => @userid})
  end

  def create
    @list = current_user.lists.build(list_params)
    if @list.save
      flash[:notice] = "List created successfully."
      flash[:class] = "alert-success"
      redirect_to(:action => 'index')
    else
      render('new')
    end
  end

  def edit
    @list = List.find(params[:id])
  end

  def update
    @list = List.find(params[:id])
    if @list.update_attributes(list_params)
      flash[:notice] = "List updated successfully."
      flash[:class] = "alert-success"
      redirect_to(:action => 'show', :id => @list.id)
    else
      render('edit')
    end
  end

  def delete
    @list = List.find(params[:id])
  end

  def destroy
    list = List.find(params[:id]).destroy
    flash[:notice] = "List '#{list.name}' deleted successfully."
    flash[:class] = "alert-success"
    redirect_to(:action => 'index')
  end

  private

    def list_params
      params.require(:list).permit(:name, :category, :background)
    end
end
