class CreateNewStories < ActiveRecord::Migration
  def change
    create_table :new_stories do |t|
      t.string :title
      t.string :content

      t.timestamps
    end
  end
end
