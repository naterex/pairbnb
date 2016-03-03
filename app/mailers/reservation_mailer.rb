class ReservationMailer < ApplicationMailer

  def booking_email(reservation)
    @reservation = Reservation.find_by(id: reservation.id)
    @days = (@reservation.end_date-@reservation.start_date).to_i
    @customer = @reservation.user
    @host = @reservation.listing.user
    @url = "http://localhost:3000/reservations/#{@reservation.id}"

    mail(to: @customer.email, subject: 'Your reservation is booked')
  end

end
