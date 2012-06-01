class StoriesController < ApplicationController

  before_filter :require_login, :only => [:create_story, :create_submission, :update]
  
  def index
    @stories = Story.all
  end
  
  def new
    @story = Story.new
  end
  
  def show
    @story = Story.find(params[:id])
    @stories = Story.all
    @users = User.all
    @invite = Invite.new
    @story_lines = @story.lines
    @new_submission = Submission.new
    @story_submissions = @story.submissions.by_votes
    @story_invites = @story.invites
  end
  
  def create_story
    @story = Story.create params[:story]
    Line.create story_id: @story.id, content: params[:post][:content], user_id: @user.id
    
    if @story.private_story == true
      Invite.create story_id: @story.id, user_id: @user.id
    end
    
    redirect_to root_url
  end
  
  def create_submission
    @story = Story.find_by_id(params[:id])
      if @story.is_free_for_all == true
        Line.create content: params[:submission][:content], story_id: params[:id], user_id: @user.id
        redirect_to story_path
      else
      Submission.create content: params[:submission][:content], story_id: params[:id], user_id: @user.id, votes: 0
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
    @submissions = Submission.by_votes.find_all_by_story_id(params[:id])
    @top_submission = @submissions.first

    top_line_vote_count = @top_submission.votes
    if Submission.find_all_by_story_id(params[:id]).count > 1
      second_line_vote_count = @submissions[1].votes
    else
      second_line_vote_count = 0
    end

    vote_total = 0
    @submissions.each do |submission|
      vote_total += submission.votes
    end

    if vote_total == 4 && @story.lines.count == 9 && @story.private_story == false
      @top_submission.enter_as_line
      @story.clear_submissions
      create_new_story
      redirect_to story_url

    elsif top_line_vote_count.to_i >= (5 - vote_total) + second_line_vote_count.to_i && @story.lines.count == 9 && @story.private_story == false
      @top_submission.enter_as_line
      @story.clear_submissions
      create_new_story
      redirect_to story_url

    elsif top_line_vote_count.to_i >= (5 - vote_total) + second_line_vote_count.to_i || vote_total == 5
      @top_submission.enter_as_line
      @story.clear_submissions
      redirect_to story_url

    elsif @submissions.empty? || Submission.find_by_id(params[:submission_id]).nil?
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

end