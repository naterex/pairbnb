class ReservationsController < ApplicationController
  before_action :require_login, only: [:create, :show, :index, :destroy]
  before_action :find_reservation, only: [:show, :destroy]

  def create
    listing = Listing.find(params[:listing_id])

    # check if current_user trying to book his own listing
    if (current_user.id == listing.user.id)
      flash[:error] = "You cannot book your own listing."
      redirect_to listing
    else

      # parse start_date, end_date from single input: daterange params
      daterange = params[:daterange]
      daterange.gsub!(/(\d{2})\/(\d{2})\/(\d{4}).-.(\d{2})\/(\d{2})\/(\d{4})/,'\3-\1-\2 \6-\4-\5')
      start_date, end_date = daterange.split(" ")

      # after move to model call it as a method
      # listing.dates_available

      @reservation = current_user.reservations.build(listing_id: params[:listing_id], start_date: start_date, end_date: end_date)

      if @reservation.dates_available?(start_date, end_date)

        if @reservation.save

          @reservation.dates.each do |date|
            @reservation.booked_dates.create(listing_id: params[:listing_id], date: date)
            # byebug
          end

          flash[:success] = "Successfully made reservation."
          redirect_to @reservation
        else
          flash[:error] = @reservation.errors.full_messages.first
          redirect_to listing
        end # @reservation.save

      else

        flash[:error] = "This listing is not available for booking from #{start_date} to #{end_date}."
        redirect_to listing

      end # dates_available? check
    end # current_user self booking check

  end

  def show
  end

  def index
    @reservations = current_user.reservations.all
  end

  def destroy
  end

  private

  def find_reservation
    @reservation = Reservation.find(params[:id])
  end

  def reservation_params
    params.require(:reservation).permit(:listing_id)
  end
end
