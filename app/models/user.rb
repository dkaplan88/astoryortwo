class User < ActiveRecord::Base
  attr_accessible :login, :name, :password, :password_confirmation
  has_many :submissions
  has_many :lines
  has_secure_password
end
