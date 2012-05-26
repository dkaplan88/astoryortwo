class Remove < ActiveRecord::Migration
  def change
    remove_column :users, :pasword_confirmation
  end
end
