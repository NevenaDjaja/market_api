class UsersController < ApplicationController
	respond_to :json
	
	def show
		resond_with User.find(params[:id])
	end
end
