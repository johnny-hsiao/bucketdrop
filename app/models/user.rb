class User < ActiveRecord::Base
  has_many :buckets
  has_many :items

  validates_presence_of :first_name, :last_name
  validates :username, presence: true,
                       uniqueness: true
  validates :email,    presence: true, 
                       format: { with: /\A.*?\@.*?\.*\Z/i }
  validates :password, presence: true,
                       length: { minimum: 8 }
end