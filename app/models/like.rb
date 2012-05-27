class Like < ActiveRecord::Base
  attr_accessible :submission_id, :user_id
  belongs_to :submission
  belongs_to :user
end
