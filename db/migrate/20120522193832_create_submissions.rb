class CreateSubmissions < ActiveRecord::Migration
  def change
    create_table :submissions do |t|
      t.integer :votes
      t.integer :user_id
      t.integer :story_id

      t.timestamps
    end
  end
end
