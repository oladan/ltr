class Point < ActiveRecord::Base
  belongs_to :user

  validates :title, presence: true
  validates :price, presence: true
  validates :place, presence: true
  
  geocoded_by :place
  after_validation :geocode, :if => :place_changed?
  after_validation :reverse_geocode, :if => :place_changed?

  reverse_geocoded_by :latitude, :longitude do |obj,results|
    if geo = results.first
      obj.street = geo.address
      obj.city   = geo.city
      obj.postal_code = geo.postal_code
      obj.state = geo.state
      obj.country = geo.country
    end
  end

  # This method associates the attribute ":avatar" with a file attachment
  has_attached_file :avatar, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>'
  }

  # Validate the attached image is image/jpg, image/png, etc
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

end
