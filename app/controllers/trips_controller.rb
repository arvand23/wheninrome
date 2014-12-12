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

  def accept
  	@trip = Trip.find(params[:id])
  	@trip.accepted_at = Time.now  #the time right now
  	@trip.user_id = current_user.id #??why isnt the syntax current_user_id or something, id itself isnt an attribute
  	@trip.save
  	redirect_to :back #puts user back where they were
  end

  def decline
  	@trip = Trip.find(params[:id])
  	@trip.declined_at = Time.now
  	@trip.user_id = current_user.id
  	@trip.save
  	redirect_to :back
  end

  #created because it was saving as nil
  private
  	def trip_params
    	params.require(:trip).permit(:email, :number_of_people, :city_id, :start_date)
  	end

end
