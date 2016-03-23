class Item < ActiveRecord::Base
  belongs_to :user, required: true
  belongs_to :bucket, required: true

  validates_presence_of :name, :status

end