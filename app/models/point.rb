class Point < ActiveRecord::Base
  belongs_to :user

  validates :title, presence: true
  validates :price, presence: true
  validates :place, presence: true
  
  geocoded_by :place
  after_validation :geocode, :if => :place_changed?

end
