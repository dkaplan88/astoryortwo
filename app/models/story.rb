class Story < ActiveRecord::Base
  attr_accessible :title
  has_many :lines
  has_many :submissions
  has_many :invites
  has_many :users, :through => :invites
  
  # def user_belongs?
  #   if @user && Invite.find_by_user_id_and_story_id(@user.id, params[:id])
  #   end
  # end
  
  
end
