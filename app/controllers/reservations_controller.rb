class ReservationsController < ApplicationController
  before_action :require_login, only: [:create, :show, :index, :destroy]
  before_action :find_reservation, only: [:show, :destroy]

  def create
    listing = Listing.find(params[:listing_id])

    # after move to model call it as a method
    # listing.check_booked

    # check if current_user trying to book his own listing
    if (current_user.id == listing.user.id)
      flash[:error] = "You cannot book your own listing."
      redirect_to listing
    else

      # parse start_date, end_date from daterange params
      daterange = params[:daterange]
      daterange.gsub!(/(\d{2})\/(\d{2})\/(\d{4}).-.(\d{2})\/(\d{2})\/(\d{4})/,'\3-\1-\2 \6-\4-\5')
      start_date, end_date = daterange.split(" ")

      @reservation = listing.reservations.build(user_id: current_user.id, start_date: start_date, end_date: end_date)

      availability = check_booked()


      if @reservation.save
        flash[:success] = "Successfully made reservation."
        redirect_to reservations_path
      else
        flash[:error] = @reservation.errors.full_messages.first
        redirect_to listing
      end
    end

  end

  def show
  end

  def index
    @reservations = current_user.reservations.all
  end

  def destroy
  end

  private

  def check_booked
    # after save callback
    # AR batch entries
    # def self.find_Whatever(x)
    #   joins(:booked_dates).where('booked_dates = ?', x)
    # end

    # if
    #   Reservation.find_by(id: 13).try(:booked_dates).where('booked_dates <= 13').nil?
    #  then somehting
    # else
    #   error = "alreayd booked"\
    # end

    # while condition
    #   begin
    #     ijggjrog
    #   rescue
    #     "Already booked"
    #   end
    # end
  end

  def find_reservation
    @reservation = Reservation.find(params[:id])
  end

  def reservation_params
    params.require(:reservation).permit(:user_id, :listing_id, :start_date, :end_date)
  end
end
