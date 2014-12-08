class ReservationsController < ApplicationController

  def create
  	@reservation = Reservation.new(res_params)

  	if @reservation.save
  		redirect_to root_path, :notice => "You just accepted or declined this user, i donnt know bro."
  	else
  		render root_path, :alert => "err"
  	end
  end

  private
  	def res_params
    	params.require(:reservation).permit(:accepted_at, :declined_at, :trip_id)
  	end

end
