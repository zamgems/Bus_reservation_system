class Owner::ReservationsController < ApplicationController
	# before_action :require_correct_owner
	before_action :require_owner
	def index
		unless params[:bus_id].blank?
	   		set_bus
	   		require_correct_owner
	      	@date = params[:date]			
	   		@reservations=@bus.reservations.where('date like ?', "%#{@date}%")
		else
			@owner = Owner.find_by(user:current_user)
			@date = params[:date]			
	   		@reservations=Reservation.where('date like ? and bus_id in (select id from buses where owner_id = ?)', "%#{@date}%", @owner)
	   		
		end
	end
	private
		def set_bus
			@bus = Bus.friendly.find(params[:bus_id])
		end
		def require_owner
			unless user_signed_in? and current_user.owner?
				redirect_to root_path, notice:"Access denied"
			end
		end

	    def require_correct_owner
	      require_owner
	      set_bus
	      unless @bus.owner == Owner.find_by(user_id:current_user.id)
	        redirect_to buses_path, alert:"Access Denied, you are not owner of that bus"
	      end
	    end
end
