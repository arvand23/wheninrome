class StaticController < ApplicationController
  def home
  	@tripinput = Trip.new #required for field. empty trip object available to the view, ie all values are nil
  	

    @charge_guid_entered = Trip.new  #DONT NEED THIS. added this because other wise it was saying nil value for charge_guid_entered
    

    # @unresponded = Trip.unresponded #no one has accepted and no one has declined these people.
    @paid = Trip.paid #need to change is its host (user) specific
  	if user_signed_in?
	  	@my_trips = Trip.where("user_id = ?", current_user.id) #find trips where user id equals current user id
      @unresponded = Trip.unresponded #no one has accepted and no one has declined these people.
	   end

     @peopletocharge = Trip.peopletocharge
  end

  def contact
  end

  def about
  end


end
