class Admin::OwnersController < ApplicationController
	#before_action :require_signin
	before_action :require_admin
	def index
		@owners = Owner.all
	end

	def approve
		owner = Owner.find(params[:id])
		owner.user.status = "approved"
		if owner.user.save
			redirect_to admin_owners_path, notice: "Owner approved"
		end
	end

	def suspend
		owner = Owner.find(params[:id])
		owner.user.status = "suspended"
		if owner.user.save
			redirect_to admin_owners_path, notice: "Owner suspended"
		end
	end

	def destroy
		owner = Owner.find(params[:id])
		user = owner.user
		if owner.destroy
			if user.destroy
				redirect_to admin_owners_path, notice: "Owner deleted"
			else
				flash[:error] = "Can not delete USER"	
			end
		else
			flash[:error] = "Can not delete OWNER"
		end
	end

	private
		def require_admin
				unless current_user.admin?
					redirect_to root_path, alert:"Access Denied"
				end
		end
end




