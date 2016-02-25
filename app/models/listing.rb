class Listing < ActiveRecord::Base
  validates_presence_of :user_id
  validates_presence_of :room_type
  validates_presence_of :property_type
  validates_presence_of :bedrooms
  validates_presence_of :bathrooms
  validates_presence_of :guests
  validates_presence_of :title
  validates_presence_of :about
  validates_presence_of :address
  validates_presence_of :city
  validates_presence_of :state
  # validates_presence_of :zip
  validates_presence_of :country

  belongs_to :user
  mount_uploader :photo, PhotoUploader

end
