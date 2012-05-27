class InvitesController < ApplicationController
  
  def create
    @invite = Invite.new
    if User.find(params[:invite][:user_id]) && !Invite.find_by_user_id_and_story_id(User.find(params[:invite][:user_id]), params[:invite][:story_id])
      @invite.story_id = params[:invite][:story_id]
      @invite.user_id = params[:invite][:user_id]
      @invite.save
      flash[:user_notice] = "User Added"
      redirect_to "/stories/#{params[:invite][:story_id]}"
    elsif !User.find(params[:invite][:user_id])
      flash[:user_notice] = "I don't think that user exists...!"
      redirect_to "/stories/#{params[:invite][:story_id]}"
    else Invite.find_by_user_id_and_story_id(User.find(params[:invite][:user_id]), params[:invite][:story_id])
      flash[:user_notice] = "I think that user is already collaborating on this story"
      redirect_to "/stories/#{params[:invite][:story_id]}"
    end
  end
  
end