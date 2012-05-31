class Story < ActiveRecord::Base
  attr_accessible :title, :private_story, :is_free_for_all
  has_many :lines
  has_many :submissions
  has_many :invites
  has_many :users, :through => :invites 
  
  
  
  def lines_left
    10 - self.lines.count
  end
end
