class ReservationMailer < ApplicationMailer

  def booking_email(reservation)
    @reservation = Reservation.find_by(id: reservation.id)
    @url = "http://localhost:3000/reservations/#{@reservation.id}"

    mail(to: @reservation.user.email, subject: 'Your reservation confirmation!')
  end

end
