class ReservationsController < ApplicationController
  before_action :require_login, only: [:new, :create, :show, :index, :destroy]
  before_action :find_reservation, only: [:show, :destroy]

  def new
    @listing = Listing.find(reservation_params[:listing_id])

    # check if current_user trying to book his own listing
    if (current_user.id == @listing.user.id)
      flash[:error] = "You cannot book your own listing."
      redirect_to @listing
    else
      daterange = reservation_params[:daterange]
      # split the dates & parse them to YYYY-MM-DD format
      start_date, end_date = daterange.split(" - ")

      @start_date = Date.parse(start_date).strftime("%Y-%m-%d")
      @end_date = Date.parse(end_date).strftime("%Y-%m-%d")

      if @start_date == @end_date
        flash[:error] = "Check-out date can't be the same as check-in date."
        redirect_to @listing
      else

        # dates = {start_date: start_date, end_date: end_date}

        # remove :daterange from reservation_params
        # reservation_params.delete_if{ | key,value | key == "daterange"}

        # add start_date, end_date to reservation_params
        # reservation_params.merge!(dates)
        reservation = current_user.reservations.build(listing_id: reservation_params[:listing_id], start_date: @start_date, end_date: @end_date)

        unless reservation.dates_available?(@start_date, @end_date)

          flash[:error] = "Your selected dates of #{@start_date.to_date.to_formatted_s(:long)} to #{@end_date.to_date.to_formatted_s(:long)} are not available for booking."
          redirect_to @listing

        end # dates_available? check
      end # start_date = end_date check
    end # current_user self booking check

  end

  def create
    listing = Listing.find(reservation_params[:listing_id])

    @reservation = current_user.reservations.build(listing_id: reservation_params[:listing_id], start_date: params[:reservation][:start_date], end_date: params[:reservation][:end_date])

    if @reservation.save
        # find all dates between start/end dates
        @reservation.dates = (@reservation.start_date..@reservation.end_date).map(&:to_s)

        # remove last date since new booking can be made on same day as late date
        @reservation.dates.pop

        @reservation.dates.each do |date|
          # created booked_dates table entries
          @reservation.booked_dates.create(listing_id: reservation_params[:listing_id], date: date)
        end

      # call the job using activejob sidekiq
      BookingEmailJob.perform_later(@reservation)

      flash[:success] = "Reservation succesfully booked. Please check your email for confirmation."
      redirect_to @reservation
    else
      flash[:error] = @reservation.errors.full_messages.first
      redirect_to listing
    end # @reservation.save

  end # create

  def show
  end

  def index
    if params[:listing_id]
      listing = Listing.find(params[:listing_id])
      @reservations = listing.reservations.all
      @index_title = "Reservations for: #{listing.title}"
      @owner_viewing = true
    else
      @reservations = current_user.reservations.all
      @index_title = "My Reservations"
      @owner_viewing = false
    end
  end

  def destroy
    # call the job using sidekiq
    CancellationEmailJob.perform_later(@reservation.listing.title, @reservation.user, @reservation.listing.id)

    @reservation.destroy
    flash[:success] = "Successfully cancelled reservation. Please check your email for confirmation."
    redirect_to reservations_path
  end

  private

  def find_reservation
    @reservation = Reservation.find(params[:id])
  end

  def reservation_params
    params.require(:reservation).permit(:listing_id, :daterange)
  end
end
