class StoryFreeForAll < ActiveRecord::Migration
  def change
    add_column :stories, :is_free_for_all, :boolean
  end
end
