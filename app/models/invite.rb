class Invite < ActiveRecord::Base
  attr_accessible :story_id, :user_id
  
  belongs_to :story
  belongs_to :user
end
