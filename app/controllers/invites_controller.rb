class InvitesController < ApplicationController
  
  def create
    @invite = Invite.new
    @invite.story_id = params[:invite][:story_id]
    @invite.user_id = params[:invite][:user_id]
    @invite.save
    redirect_to "/stories/#{params[:invite][:story_id]}"
  end
  
end