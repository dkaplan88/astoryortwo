class CreateLines < ActiveRecord::Migration
  def change
    create_table :lines do |t|
      t.string :content
      t.integer :user_id
      t.integer :story_id

      t.timestamps
    end
  end
end
