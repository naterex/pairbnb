class Reservation < ActiveRecord::Base
  belongs_to :user
  belongs_to :listing
  has_many :booked_dates, dependent: :destroy
end
