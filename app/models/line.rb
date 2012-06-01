class Line < ActiveRecord::Base
  attr_accessible :content, :story_id, :user_id
  belongs_to :story
  belongs_to :user
  belongs_to :public_stories

  def create_line
    self.content = newline.content
    self.story_id = params[:id]
    self.save
  end

end
