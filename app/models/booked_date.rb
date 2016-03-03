class BookedDate < ActiveRecord::Base
  belongs_to :listing
  belongs_to :reservation
end
