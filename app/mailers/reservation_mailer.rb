class ReservationMailer < ApplicationMailer

  def booking_email(reservation)
    @reservation = Reservation.find_by(id: reservation.id)
    @url = "http://localhost:3000/reservations/#{@reservation.id}"

    mail(to: @reservation.user.email, subject: 'Your reservation is booked!')
  end

  def cancellation_email(reservation_listing_title, reservation_user, reservation_listing_id)
    @reservation_listing_title = reservation_listing_title
    @reservation_user = reservation_user
    @url = "http://localhost:3000/listings/#{reservation_listing_id}"
    mail(to: @reservation_user.email, subject: 'Your reservation is cancelled!')
  end

end
