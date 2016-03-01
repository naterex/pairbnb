class Listing < ActiveRecord::Base
  validates_presence_of :user_id
  validates_presence_of :price
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
  mount_uploaders :photos, PhotoUploader

  has_many :reservations, dependent: :destroy
  has_many :booked_dates, dependent: :destroy


  def self.search(query)
    where(["city ilike ? or country ilike ? or zip ilike ? or state ilike ?", "%#{query}%", "%#{query}%", "%#{query}%", "%#{query}%"])
  end


end
