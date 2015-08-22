class AlterOverview < ActiveRecord::Migration
  def change
  	change_column("movies", "overview", :string, :limit => 1000)
  end
end
