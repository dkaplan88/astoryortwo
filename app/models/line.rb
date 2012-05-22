class Line < ActiveRecord::Base
  attr_accessible :content, :story_id, :user_id
  belongs_to :story
end
