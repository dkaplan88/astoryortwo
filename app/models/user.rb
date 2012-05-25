class User < ActiveRecord::Base
  attr_accessible :login, :name, :password, :password_confirmation
  has_many :submissions
  has_many :lines
  has_many :invites
  has_many :stories, :through => :invites
  has_secure_password
end
