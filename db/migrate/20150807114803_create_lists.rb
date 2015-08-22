class CreateLists < ActiveRecord::Migration
  def up
    create_table :lists do |t|
    	t.integer "user_id"
    	t.string "name", :limit => 20
    	t.string "type"
      t.timestamps
    end
    add_index("lists", "user_id")
    def down
    	drop_table :lists
    end
  end
end
