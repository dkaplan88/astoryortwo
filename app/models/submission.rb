class Submission < ActiveRecord::Base
  attr_accessible :story_id, :user_id, :votes, :content
  belongs_to :story
  belongs_to :user
  belongs_to :public_story
  has_many :likes
  scope :by_votes, order: "votes DESC"
  validates_presence_of :content

  def enter_as_line
    Line.create content: self.content, story_id: self.story.id
  end


end