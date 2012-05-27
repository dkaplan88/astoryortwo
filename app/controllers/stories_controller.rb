class StoriesController < ApplicationController

  before_filter :require_login, :only => [:create]
  
  def index
    @stories = Story.all
  end
  
  def show
    @invite = Invite.new
    @story = Story.find(params[:id])
    @story_lines = @story.lines
    @new_submission = Submission.new
    @story_submissions = Submission.by_votes.find_all_by_story_id(params[:id])
    @story_invites = @story.invites
  end
  
  def create
    submission = Submission.new
    submission.content = params[:submission][:content]
    submission.story_id = params[:id]
    submission.user_id = @user.id
    submission.votes = 0
    if submission.save
      flash[:save_notice] = "Thanks homie!"
      redirect_to story_url
    else
      flash[:alert] = "Pew pew try again"
      redirect_to story_url
    end
  end
  
  def update
    top_line_vote_count = Submission.by_votes.find_all_by_story_id(params[:id]).first.votes
    if Submission.find_all_by_story_id(params[:id]).count > 1
      second_line_vote_count = Submission.by_votes.find_all_by_story_id(params[:id])[1].votes
    else
      second_line_vote_count = 0
    end
    
    vote_total = 0
    submissions = Submission.by_votes.find_all_by_story_id(params[:id])
    submissions.each do |submission|
    vote_total += submission.votes
    end
    
    # if session[:vote_time] && (Time.now - session[:vote_time] < 1800)
    if session[:submission_id] == Submission.find_by_id(params[:submission_id])
      flash[:notice] = "Only 1 Vote Per Submission...Please!" 
      redirect_to story_url and return story_url
    else
    #@submission = Submission.find_by_id(params[:id])
      # session[:vote_time] = Time.now
      session[:submission_id] = Submission.find_by_id(params[:submission_id])
    end
    
    if vote_total == 9 && Line.find_all_by_story_id(params[:id]).count == 9
      submission_to_line_create_new_story
    elsif top_line_vote_count.to_i >= (10 - vote_total) + second_line_vote_count.to_i && Line.find_all_by_story_id(params[:id]).count == 9
        submission_to_line_create_new_story
    elsif top_line_vote_count.to_i >= (10 - vote_total) + second_line_vote_count.to_i || vote_total == 9 
      submission_to_line
    elsif Submission.find_all_by_story_id(params[:id]).empty? || Submission.find_by_id(params[:submission_id]).nil?
      #FLASH NOTICE
      redirect_to story_url
    else
      submit_vote
    end
  end
end