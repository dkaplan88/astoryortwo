class Submission < ActiveRecord::Base
  attr_accessible :story_id, :user_id, :votes
  belongs_to :story
end


def create_submission
  submission = Submission.new
  submission.content = params[:submission][:content]
  submission.story_id = params[:id]
  submission.votes = 0
  if submission.save
    flash[:save_notice] = "Thanks homie!"
    redirect_to story_url
  else
    flash[:alert] = "Pew pew try again"
    redirect_to story_url
  end
end