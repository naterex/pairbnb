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

      daterange = params[:daterange]
      # parse daterange into YYYY-MM-DD format
      daterange.gsub!(/(\d{2})\/(\d{2})\/(\d{4}).-.(\d{2})\/(\d{2})\/(\d{4})/,'\3-\1-\2 \6-\4-\5')
      # extract start_date, end_date from daterange
      start_date, end_date = daterange.split(" ")

      @reservation = current_user.reservations.build(listing_id: params[:listing_id], start_date: start_date, end_date: end_date)

      if @reservation.dates_available?(start_date, end_date)

        if @reservation.save

          # created booked_dates table entries
          @reservation.dates.each do |date|
            @reservation.booked_dates.create(listing_id: params[:listing_id], date: date)
          end

          # call the mailer like a model class with the necessary arguments
          ReservationMailer.booking_email(@reservation).deliver_now

          flash[:success] = "Successfully made reservation."
          redirect_to @reservation
        else
          flash[:error] = @reservation.errors.full_messages.first
          redirect_to listing
        end # @reservation.save

      else
        # start_date = start_date.to_formatted_s(:long)
        # end_date = end_date.to_formatted_s(:long)
        flash[:error] = "This listing is not available for booking for your selected dates of #{start_date.to_formatted_s(:long)} to #{end_date.to_formatted_s(:long)}."
        redirect_to listing

      end # dates_available? check
    end # current_user self booking check
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
    @reservation.destroy
    flash[:success] = "Successfully canceled reservation."
    redirect_to reservations_path
  end

  private

  def find_reservation
    @reservation = Reservation.find(params[:id])
  end

  def reservation_params
    params.require(:reservation).permit(:listing_id)
  end
end
