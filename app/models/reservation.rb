class Reservation < ActiveRecord::Base
  validates_presence_of :user_id
  validates_presence_of :listing_id
  validates_presence_of :start_date
  validates_presence_of :end_date
  validates_uniqueness_of :start_date, scope: :end_date, message: "cannot be the same as end date."
  validate :start_date_cannot_be_in_the_past

  belongs_to :user
  belongs_to :listing
  has_many :booked_dates, dependent: :destroy

  # allow @dates instance variable to be passed back to Reservation controller
  attr_accessor :dates

  def start_date_cannot_be_in_the_past
    if start_date < Date.today
      errors.add(:start_date, " can't be in the past.")
    end
  end


  def dates_available?(start_date, end_date)
    # find all dates between start/end dates
    @dates = (start_date..end_date).map(&:to_s)
    # remove last date since new booking can be made on same day as late date
    @dates.pop

    #check each date against booked_dates table
    @dates.each do |search_date|

      # if date = booked_date
      if listing.booked_dates.where("date = ?", search_date).present?

        # return dates_available? = false
        return false
        break
      else
        # else return dates_available? = true
        return true
      end

    end
  end

end
