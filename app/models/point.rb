class Point < ActiveRecord::Base
  belongs_to :user
  belongs_to :type
  has_many :pictures, :dependent => :destroy

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
  has_attached_file :avatar,
  styles: {
    thumb:  '100x100>',
    square: '170x170#',
    medium: '300x300>'
  },
  storage: :s3,
  s3_host_name: ENV['S3_HOST'],
  bucket: ENV['S3_BUCKET_NAME'],
  s3_credentials: {
    access_key_id:     ENV['AWS_ACCESS_KEY_ID'],
    secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
  }

  # Validate the attached image is image/jpg, image/png, etc
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  def avatar_url
    if avatar.exists?
      avatar_url = avatar.url(:square)
    else
      avatar_url = 'tmp.jpg'
    end
  end

  def pics
    @result = {}
    pictures.each do |value|
      @result[value.id] = value.pic.url(:large)
    end
    @result
  end
end
