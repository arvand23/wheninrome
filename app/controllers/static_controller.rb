class StaticController < ApplicationController
  def home
  	@tripinput = Trip.new #required for field. empty trip object available to the view, ie all values are nil
  	

    @charge_guid_entered = Trip.new  #DONT NEED THIS. added this because other wise it was saying nil value for charge_guid_entered
    





    # @unresponded = Trip.unresponded #no one has accepted and no one has declined these people.
    @paid = Trip.paid #need to change is its host (user) specific
  	if user_signed_in?
	  	@my_trips = Trip.where("user_id = ?", current_user.id) #find trips where user id equals current user id
      @unresponded = Trip.unresponded #no one has accepted and no one has declined these people.
      @currentuser_declined_this = Decline.where("user_id = ?", current_user.id).pluck(:trip_id) #grab the trip id's from the declines table if the user id is the current user
      
      #render json: @currentuser_declined_this and return
      @user_can_accept_these = Trip.unaccepted.where.not(id: @currentuser_declined_this) #where the id is not this function. 
	   end

     @peopletocharge = Trip.peopletocharge
  end

  def contact
  end

  def about
  end


end
