class StoriesController < ApplicationController

  def index
    @stories = Story.all
  end
  
  def show
    @story = Story.find(params[:id])
    @story_lines = @story.lines
    @new_submission = Submission.new
    @story_submissions = @story.submissions
  end
  
  def create
    create_submission
  end
end