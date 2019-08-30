class BusesController < ApplicationController
  def index
      @buses=Bus.available_buses(params)
      
      # @buses= Bus.where("status = 'available' and owner_id in ( select id from owners where user_id in (select id from users where status = 'approved' and role = 'owner' )  ) ")           
  end
end