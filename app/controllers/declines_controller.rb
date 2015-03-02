class DeclinesController < ApplicationController

  def realdecline
	@decline = Decline.new#(decline_params)  #creating a brand new entry
	@current_trip = Trip.find(params[:id])

	@decline.user_id = current_user.id
	@decline.trip_id = @current_trip.id
	@decline.save
	redirect_to :back, :notice => "You declined #{@current_trip.email}."


  	#@decline = Trip.find(params[:id]) #anything your finding something, when u need access to a specific trip / entry, u pass ID u want to manipulate
  	#@decline.user_id = current_user.id
  	#@decline.trip_id = @decline
  	#@decline.save
  	#redirect_to :back
  end

  private
	def decline_params
    	params.require(:decline).permit(:user_id)
  	end

end
