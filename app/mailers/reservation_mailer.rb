class ReservationMailer < ApplicationMailer
  def reservation_confirmed_mail
    @user = params[:user]
    @bus_name = params[:bus_name]
    @seats = params[:seats]
    @url  = 'localhost:3000/reservations'
    mail(to: @user.email, subject: 'Your reservation is confirmed')
  end
end
