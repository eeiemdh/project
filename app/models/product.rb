class Product < ActiveRecord::Base
  attr_accessible :product_url, :user_id, :video, :remote_image_url, :questions_attributes, :comments_attributes

  has_many :questions, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  accepts_nested_attributes_for :comments, :reject_if => lambda { |a| a[:content].blank? }, :allow_destroy => true

  accepts_nested_attributes_for :questions, :reject_if => lambda { |a| a[:content].blank? }, :allow_destroy => true
  mount_uploader :video, VideoUploader
end


