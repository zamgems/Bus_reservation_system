class Admin::BusesController < ApplicationController
  def index
  	if params[:owner_id].blank?
  	  if params[:source].blank? and params[:destination].blank? and params[:name].blank?
  	  	@buses = Bus.all
  	  else
  	  	@buses=Bus.search_buses(params)
  	  end
  	else
  	  @owner = Owner.find(params[:owner_id])
  	  if params[:source].blank? and params[:destination].blank? and params[:name].blank?
  	  	@buses = @owner.buses
  	  else
  	  	@buses=@owner.buses.search_buses(params)
  	  end
  	end
  end
end