class Owner::BusesController < ApplicationController
	before_action :require_owner
  	before_action :set_owner, except: [:index]
  	before_action :set_bus,only: [:show,:edit]
  	before_action :require_correct_owner, only: [:show, :edit, :update, :destroy]

	def index
		@owner = Owner.find_by(user:current_user)
    	@search = if params[:source]
        	@buses=@owner.buses.where('source LIKE ? and destination LIKE ? and name LIKE ?', "%#{params[:source]}%", "%#{params[:destination]}%", "%#{params[:name]}%")
    	else
        	@buses=@owner.buses
    	end
	end

	def show

	end
	  
  def new
    @bus = Bus.new
  end

  def edit

  end

  def create
    @bus = Bus.new(bus_params)
    @owner =  Owner.find_by(user_id:current_user.id)
    @bus.owner_id = @owner.id
    respond_to do |format|
      if @bus.save

        format.html { redirect_to owner_buses_path, notice: 'Bus was successfully created.' }
        format.json { render :show, status: :created, location: @bus }
      else
        format.html { render :new }
        format.json { render json: @bus.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @bus.update(bus_params)
        format.html { redirect_to owner_buses_path, notice: 'Bus was successfully updated.' }
        format.json { render :show, status: :ok, location: @bus }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @bus.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @bus.destroy
    respond_to do |format|
      format.html { redirect_to owner_buses_path, notice: 'Bus was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  	private
	    # Use callbacks to share common setup or constraints between actions.
	    def set_bus
	      @bus = Bus.friendly.find(params[:id])
	    end
	    def set_owner
	      @owner = Owner.find_by(user_id:current_user.id)
	    end
	    # Never trust parameters from the scary internet, only allow the white list through.
	    def bus_params
	      params.require(:bus).permit(:name, :registration_no, :source, :destination, :total_seats, :status)
	    end

	    def require_owner
			unless user_signed_in? and current_user.owner?
				redirect_to root_path, notice:"Access denied"
			end
		end

	    def require_correct_owner
	      require_owner
	      set_bus
	      unless @bus.owner == Owner.find_by(user:current_user)	
	        redirect_to owner_buses_path, alert:"Access Denied, you are not owner of that bus"
	      end
	    end
end
