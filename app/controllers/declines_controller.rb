class DeclinesController < ApplicationController

	def realdecline
  	@trip = Trip.find(params[:id]) #anything your finding something, when u need access to a specific trip / entry, u pass ID u want to manipulate
  	@trip.declined_at = Time.now
  	@trip.user_id = current_user.id
  	@trip.save
  	redirect_to :back
  end

end
