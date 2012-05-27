class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :find_user
  
  def find_user
    @user = User.find_by_id(session[:login_id])
    return @user
  end
  
  def require_login
    if @user.blank?
      redirect_to root_url, notice: "You must be logged in!"
    end
  end
  # def create_submission
  #   submission = Submission.new
  #   submission.content = params[:submission][:content]
  #   submission.story_id = params[:id]
  #   submission.user_id = @user.id
  #   submission.votes = 0
  #   if submission.save
  #     flash[:save_notice] = "Thanks homie!"
  #     redirect_to story_url
  #   else
  #     flash[:alert] = "Pew pew try again"
  #     redirect_to story_url
  #   end
  # end

  # To display count-down of votes
  # def votes_left
  #   vote_total = 10
  #   # @submissions = Submission.find_all_by_story_id(params[:id])
  #   @submissions.each do |submission|
  #   vote_total -= submission.votes
  #   end
  #   vote_total
  # end

  def submit_vote
    submission = Submission.find_by_id(params[:submission_id])
    Like.create user_id: @user.id, submission_id: submission.id
    submission.votes = submission.likes.count
    submission.save
    redirect_to story_url
  end

  def submission_to_line
    newlines = Submission.by_votes.find_all_by_story_id(params[:id])
    newline = newlines.first
    line = Line.create :content => newline.content, :story_id => params[:id], :user_id => newline.user_id
    Submission.scoped({:conditions => ['story_id = ?', params[:id]]}).destroy_all
    redirect_to story_url
  end

  def submission_to_line_create_new_story
    newlines = Submission.by_vote.find_all_by_story_id(params[:id])
    newline = newlines.first
    line = Line.create :content => newline.content, :story_id => params[:id]
    Submission.scoped({:conditions => ['story_id = ?', params[:id]]}).destroy_all
    create_story
    redirect_to story_url  
  end
  
  
end
