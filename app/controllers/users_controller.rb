class UsersController < ApplicationController
#TO DO: AUTOCOMPLETE SUBMIT FORM, FIGURE OUT HOW TO DOWNCASE NAMES...?
  
  def show
  end
  
  def update
    if User.find_by_name(params[:q]) && !Invite.find_by_user_id_and_story_id(@user.id, params[:id])
      Invite.create story_id: params[:id], user_id: User.find_by_name(params[:q]).id
      redirect_to story_url
    elsif !User.find_by_name(params[:q])
      flash[:notice] = "I don't think that user exists...!"
      redirect_to story_url
    else Invite.find_by_user_id_and_story_id(@user.id, params[:id])
      flash[:notice] = "I think that user is already collaborating on this story"
      redirect_to story_url      
    end
  end
end