class UsersController < ApplicationController
#TO DO: AUTOCOMPLETE SUBMIT FORM, FIGURE OUT HOW TO DOWNCASE NAMES...?
  def index
    @users = User.all
  end
  
  def show
    @user = User.find_by_id(params[:id])
  end
  
  def new
    @user = User.new
  end
  
  def update
    if User.find_by_name(params[:q]) && !Invite.find_by_user_id_and_story_id(User.find_by_name(params[:q]).id, params[:id])
      Invite.create story_id: params[:id], user_id: User.find_by_name(params[:q]).id
      redirect_to story_url
    elsif !User.find_by_name(params[:q])
      flash[:notice] = "I don't think that user exists...!"
      redirect_to story_url
    else Invite.find_by_user_id_and_story_id(User.find_by_name(params[:q]).id, params[:id])
      flash[:notice] = "I think that user is already collaborating on this story"
      redirect_to story_url
    end
  end
  
  def create
    @user = User.new(params[:user])
    
    respond_to do |format|
      if @user.save
        format.html { redirect_to root_url, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
end