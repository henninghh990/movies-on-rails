class AddBackgroundToList < ActiveRecord::Migration
  def change
  	add_column("lists", "background", :integer, :default => '1')
  end
end
