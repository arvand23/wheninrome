class StaticController < ApplicationController
  def home
  	@tripinput = Trip.new #empty trip object available to the view, ie all values are nil
  	@trips = Trip.unresponded
  	if user_signed_in?
	  	@my_trips = Trip.where("user_id = ?", current_user.id)
	end
  end

  def contact
  end

  def about
  end


end
