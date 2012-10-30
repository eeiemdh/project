class Product < ActiveRecord::Base
  attr_accessible :product_url, :user_id, :video, :remote_image_url, :questions_attributes

  has_many :questions, :dependent => :destroy
  accepts_nested_attributes_for :questions, :reject_if => lambda { |a| a[:content].blank? }, :allow_destroy => true
  mount_uploader :video, VideoUploader
end
