# -*- encoding : utf-8 -*-

class Picture < ActiveRecord::Base
  
  attr_accessible :image

  mount_uploader :image, ImageUploader

end
