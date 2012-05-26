class CreatePublicStories < ActiveRecord::Migration
  def change
    create_table :public_stories do |t|
      t.string :title

      t.timestamps
    end
  end
end
