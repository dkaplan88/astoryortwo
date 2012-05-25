class Story < ActiveRecord::Base
  attr_accessible :title
  has_many :lines
  has_many :submissions
  has_many :invites
  has_many :users, :through => :invites

end
