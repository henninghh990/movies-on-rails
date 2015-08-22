class AlterLists < ActiveRecord::Migration
  def change
  	rename_column("lists", "type", "category")
  end
end
