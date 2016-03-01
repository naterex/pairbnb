class ReservationsController < ApplicationController
  before_action :require_login, only: [:create, :show, :index, :edit, :update, :destroy]
  # before_action :check_lister_self_reservation, only: [:create]
  # before_action :check_booked, only: [:create, :edit, :update]
  before_action :find_reservation, only: [:show, :edit, :update, :destroy, :check_lister_self_reservation, :check_booked]

  def new
  end

  def create
    listing = Listing.find(params[:listing_id])

    daterange = params[:daterange]
    daterange.gsub!(/(\d{2})\/(\d{2})\/(\d{4}).-.(\d{2})\/(\d{2})\/(\d{4})/,'\3-\1-\2 \6-\4-\5')
    start_date, end_date = daterange.split(" ")

    @reservation = listing.reservations.build(user_id: current_user.id, start_date: start_date, end_date: end_date)


    if @reservation.save
      flash.now[:success] = "Successfully made reservation."
      redirect_to reservations_path
    else
      flash.now[:error] = @reservation.errors.full_messages.first
      render listing
    end
  end

  def show
  end

  def index
    # byebug
    @reservations = current_user.reservations.all
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def check_lister_self_reservation
    if signed_in? && (current_user.id == @listing.user.id)
      flash.now[:error] = "You cannot reserve your own listing."
      render @listing
    end
  end

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
