class Product < ActiveRecord::Base
  attr_accessible :product_url, :user_id, :video
   mount_uploader :video, VideoUploader
end
