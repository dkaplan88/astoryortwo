class Team < ActiveRecord::Base
  attr_accessible :story_id, :user_id
  
  has_one :story
  has_many :users

end
