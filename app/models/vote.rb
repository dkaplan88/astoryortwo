class Vote < ActiveRecord::Base
  attr_accessible :submission_id, :user_id
  
end
