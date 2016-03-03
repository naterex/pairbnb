class ReservationMailer < ApplicationMailer

  def booking_email(reservation)
    @reservation = Reservation.find_by(id: reservation.id)
    @url = "http://localhost:3000/reservations/#{@reservation.id}"

    mail(to: @reservation.user.email, subject: 'Your reservation is booked!')
  end

  def cancellation_email(reservation_title, user, listing_id)
    @reservation_title = reservation_title
    @user = user
    @url = "http://localhost:3000/listings/#{listing_id}"
    mail(to: @user.email, subject: 'Your reservation is cancelled!')
  end

end
