class TripsController < ApplicationController
	 #created for the submit action in home
  def create
  	@trip = Trip.new(trip_params) #changed from params[:id] which was saving as nil

  	if @trip.save
  		redirect_to root_path, :notice => "A host will email #{Trip.last.email}!"  #change you to the email they just submitted Trip.last.email
  	else
  		render root_path, :alert => "err"
  	end
  end

  #created because it was saving as nil
  private
  	def trip_params
    	params.require(:trip).permit(:email, :number_of_people, :city_id, :start_date)
  	end

end
