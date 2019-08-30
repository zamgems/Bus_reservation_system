class ReservationsController < ApplicationController
	helper_method :is_seat_available?
	def index
		@reservations = current_user.reservations.future_reservations
		@past_reservations = current_user.reservations.past_reservations
	end

	def new
		@bus = Bus.friendly.find(params[:bus_id])
		@customer = current_user
		@reservation = Reservation.new
    	@seats = Array(1..@bus.total_seats)
	end

	def create
		@bus = Bus.friendly.find(params[:bus_id])
   		@customer = current_user
		reservation_parameters = params.require(:reservation).permit(:no_of_seats,:date)
		@reservation = Reservation.new(reservation_parameters)
		@reservation.user = @customer
		@reservation.bus = @bus
		seats_parameters = params.require(:reservation).permit(:seat_ids=>[])
		if @reservation.save
			reserved_set
			redirect_to buses_path, notice:"Bus reserved"
		else
			flash[:error] = "Booking was not done"
			redirect_to bus_reservations_path(@bus)	
		end
	end


	def reserved_set
	  	r = params["reservation"]
	   	a = r[:seat_ids]
   		seat_nos= a.select {|n|   n!='0' }
    	seat_nos.each do |s_n|
    		@reservation.seats.create(seat_no:s_n)
		end
	end

	def available_seats
		seats = []
   		for i in 1..@bus.total_seats do
   			if is_seat_available?(i)
   				seats.push(i)
   			end
   		end
   		seats
	end

	def destroy
		@reservation = Reservation.find(params[:id])
    	@reservation.destroy
    	respond_to do |format|
    		format.html { redirect_to reservations_path, notice: 'Reservation is successfully destroyed.' }
      		format.json { head :no_content }
      		format.js
   		end
  end
  def cancel
  		@reservation = Reservation.find(params[:id])
  		@reservation.status = "inactive"
  		if @reservation.save
  			redirect_to reservations_path, notice: 'Reservation is successfully canceled.' 
  		end
  end
def show_seats		
	@bus = Bus.friendly.find(params[:bus_id])
		@reservation = @bus.reservations.new
		@customer = current_user
	@date = params[:date].nil? ? Time.now.strftime("%d-%m-%Y") : params[:date]
	@total_seats = Array(1..params[:total_seats].to_i)
	@remaining_seats = 0
	for i in 1..@total_seats.size do
		@remaining_seats += is_seat_available?(i,@date) ? 1 : 0
	end
end
def is_seat_available?(seat_number,date)
	@reservations = @bus.reservations.where(date:date)
	@reservations.each do |reservation|
		seats = reservation.seats
		if seats.map(&:seat_no).include?(seat_number)
			return false
		end
	end
	return true
end

end



