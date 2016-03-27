class Bucket < ActiveRecord::Base
  belongs_to :user, required: true
  has_many :items, dependent: :destroy

  validates_presence_of :name, :rating
  
end