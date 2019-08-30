class Admin::ReservationsController < ApplicationController
	before_action :require_admin
	def index
		if params[:bus_id].blank?
	   		if params[:owner_id].blank?            #for admin/reservations
				@date = params[:date]			
	   			@reservations=Reservation.where('date like ?', "%#{@date}%")
			else
				@owner = Owner.find(params[:owner_id])
				@date = params[:date]			#for admin/owners/:owner_id/reservations
	   			@reservations=Reservation.where('date like ? and bus_id in (select id from buses where owner_id = ?) ', "%#{@date}%", @owner.id)
			end
		else
											#for admin/buses/:buses_id/reservations and /admin/owners/:owner_id/buses/:bus_id/reservations
	    	set_bus 
	      	@date = params[:date]			
	   		@reservations=@bus.reservations.search_by_date(@date)
		end
	end
	private
		def set_bus
			@bus = Bus.friendly.find(params[:bus_id])
		end
		def require_admin
				unless current_user.admin?
					redirect_to root_path, alert:"Access Denied"
				end
		end
end
