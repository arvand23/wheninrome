class StaticController < ApplicationController
  def home
  	@tripinput = Trip.new #empty trip object available to the view, ie all values are nil
  	@alltrips = Trip.all



  	@reservationinput = Reservation.new 
  end

  def contact
  end

  def about
  end


end
