class User < ActiveRecord::Base
  has_many :buckets
  has_many :items

  validates_presence_of :first_name, :last_name, :username, :email, :password
  
end