class IsStoryPrivate < ActiveRecord::Migration
  def change
    add_column :stories, :private_story, :boolean
  end
end