class UsersController < ApplicationController
  def show
  end
  
  def update
    Invite.create story_id: params[:id], user_id: User.find_by_name(params[:q]).id
    redirect_to story_url
  end
end