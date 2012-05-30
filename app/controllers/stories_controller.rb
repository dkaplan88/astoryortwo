class StoriesController < ApplicationController

  before_filter :require_login, :only => [:create_story, :create_submission, :update]
  
  def index
    @stories = Story.all
  end
  
  def show
    @stories = Story.all
    @users = User.all
    @invite = Invite.new
    @story = Story.find(params[:id])
    @story_lines = @story.lines
    @new_submission = Submission.new
    @story_submissions = Submission.by_votes.find_all_by_story_id(params[:id])
    @story_invites = @story.invites
  end
  
  def create_story
    @story = Story.new
    @story.title = params[:story][:title]
    @story.is_free_for_all = params[:story][:is_free_for_all]
    @story.private_story = params[:story][:private_story]
    # @story.private_story = true
    @story.save
    Invite.create story_id: @story.id, user_id: @user.id
    Line.create story_id: @story.id, content: params[:post][:content], user_id: @user.id
    redirect_to root_url
  end
  
  def create_submission
    @story = Story.find_by_id(params[:id])
      if @story.is_free_for_all == true
        Line.create content: params[:submission][:content], story_id: params[:id], user_id: @user.id
        redirect_to story_path
      else
      submission = Submission.new
      submission.content = params[:submission][:content]
      submission.story_id = params[:id]
      submission.user_id = @user.id
      submission.votes = 0
      if submission.save
        flash[:notice] = "Thanks for submitting"
        redirect_to story_url
      else
        flash[:notice] = "Nice! Now try writing something this time..."
        redirect_to story_url
      end
    end
  end
  
  def update
    @story = Story.find(params[:id])
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
    
    if vote_total == 9 && Line.find_all_by_story_id(params[:id]).count == 9 && @story.private_story == false
      newlines = Submission.by_vote.find_all_by_story_id(params[:id])
      newline = newlines.first
      line = Line.create :content => newline.content, :story_id => params[:id]
      Submission.scoped({:conditions => ['story_id = ?', params[:id]]}).destroy_all
      create_new_story
      redirect_to story_url
    elsif top_line_vote_count.to_i >= (10 - vote_total) + second_line_vote_count.to_i && Line.find_all_by_story_id(params[:id]).count == 9 && @story.private_story == false
      newlines = Submission.by_votes.find_all_by_story_id(params[:id])
      newline = newlines.first
      line = Line.create :content => newline.content, :story_id => params[:id]
      Submission.scoped({:conditions => ['story_id = ?', params[:id]]}).destroy_all
      create_new_story
      redirect_to story_url
    elsif top_line_vote_count.to_i >= (10 - vote_total) + second_line_vote_count.to_i || vote_total == 9 
      newlines = Submission.by_votes.find_all_by_story_id(params[:id])
      newline = newlines.first
      line = Line.create :content => newline.content, :story_id => params[:id], :user_id => newline.user_id
      Submission.scoped({:conditions => ['story_id = ?', params[:id]]}).destroy_all
      redirect_to story_url
    elsif Submission.find_all_by_story_id(params[:id]).empty? || Submission.find_by_id(params[:submission_id]).nil?
      #FLASH NOTICE
      redirect_to story_url
    elsif Like.find_by_submission_id_and_user_id(params[:submission_id], @user.id)
        flash[:notice] = "Only 1 vote per submission please"
        redirect_to story_url
    else
      submission = Submission.find_by_id(params[:submission_id])
      Like.create user_id: @user.id, submission_id: submission.id
      submission.votes = submission.likes.count
      submission.save
      redirect_to story_url
    end
  end
  
  def new
    @story = Story.new
  end
  
end