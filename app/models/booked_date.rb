class BookedDate < ActiveRecord::Base
  validates_presence_of :reservation_id
  validates_presence_of :listing_id
  validates_presence_of :date

  belongs_to :listing
  belongs_to :reservation
end
