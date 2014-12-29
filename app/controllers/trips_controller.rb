class TripsController < ApplicationController
	 #created for the submit action in home
   ###whenever theres an action that doesnt have a view associated with it you need to end it with a redirect_to :something
  def create
  	@trip = Trip.new(trip_params) #changed from params[:id] which was saving as nil  #user .new when ur creating an entry and .find paramsid when u have one and doing something to it

  	if @trip.save
  		redirect_to root_path, :notice => "A host will email #{Trip.last.email}!"  #change you to the email they just submitted Trip.last.email
  	else
  		render root_path, :alert => "err"
  	end
  end

  def accept
  	@trip = Trip.find(params[:id])
    @trip.accept!(current_user)  ##moved code from controller to model  runs the accept! method from model. ie trip.find... find a method on active record
  	NotificationMailer.checkout(@trip).deliver  #checkout generates it, deliver sends it
    redirect_to :back, :notice => "Once #{@trip.email} makes a payment, you'll be notified to host him." #puts user back where they were
  end



  def decline
  	@trip = Trip.find(params[:id]) #anything your finding something, when u need access to a specific trip / entry, u pass ID u want to manipulate
  	@trip.declined_at = Time.now
  	@trip.user_id = current_user.id
  	@trip.save
  	redirect_to :back
  end


#pass trip object (trip.find) into mailer


  def checkout  #originally made this so that trips/checkout URL works
    #grab a trip ID
    @travellerinput = Trip.accepted.find_by_permalink(params[:id])    #only trips that have been accepted, so trips that havent been accepted nothing will show. accepted defined in trip.rb. it was Trip.accepted.find(params[:id])
  end


  def pay
    #button they click that submits the data
    @trip = Trip.find(params[:id])
    if @trip.update_attributes(stripe_params)
      #redirect success... create a success view?
    else
      render :checkout
    end
  end

  #because create was saving as nil
  private
  	def trip_params
    	params.require(:trip).permit(:email, :number_of_people, :city_id, :start_date)
  	end

    def stripe_params
      params.require(:trip).permit(:card_id)
    end

end
