class UserMailer < ApplicationMailer
  default from: 'zamirmanihar@gmail.com'

  def welcome_email
    @user = params[:user]
    @url  = 'localhost:3000/login'
    mail(to: @user.email, subject: 'Welcome to Bus Reservations')
  end
end
