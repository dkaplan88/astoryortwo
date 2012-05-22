class AddContentToSubmission < ActiveRecord::Migration
  def change
    add_column :submissions, :content, :string
  end
end
