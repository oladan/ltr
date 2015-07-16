class Picture < ActiveRecord::Base
  belongs_to :point

  # This method associates the attribute ":avatar" with a file attachment
  has_attached_file :pic, 
  styles: {
    thumb:  '100x100>',
    square: '200x200#',
    medium: '300x300>',
    large: '1280x720#',
  }, 
  storage: :s3, 
  s3_host_name: ENV['S3_HOST'],
  bucket: ENV['S3_BUCKET_NAME'],
  s3_credentials: {
    access_key_id:     ENV['AWS_ACCESS_KEY_ID'],
    secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
  }

  # Validate the attached image is image/jpg, image/png, etc
  validates_attachment_content_type :pic, :content_type => /\Aimage\/.*\Z/

  def pic_square
    if pic.exists?
      pic_url = pic.url(:square)
    else
      pic_url = 'tmp.jpg'
    end
  end

end
