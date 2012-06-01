class Story < ActiveRecord::Base
  attr_accessible :title, :private_story, :is_free_for_all
  has_many :lines
  has_many :submissions
  has_many :invites
  has_many :users, :through => :invites 

  def is_complete?
    if self.lines.count == 10
      puts "Story is complete"
      return true
    else
      return false
    end
  end

  def lines_left
    10 - self.lines.count
  end
  
  def clear_submissions
    self.submissions.destroy_all
  end
end
