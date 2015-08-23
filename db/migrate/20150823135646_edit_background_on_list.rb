class EditBackgroundOnList < ActiveRecord::Migration
  def change
  	change_column("lists", "background", :string, :default => '1')
  end
end
