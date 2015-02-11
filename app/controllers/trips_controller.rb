class TripsController < ApplicationController
	 #created for the submit action in home
   ###whenever theres an action that doesnt have a view associated with it you need to end it with a redirect_to :something
  def create
  	@tripinput = Trip.new(trip_params) #changed from params[:id] which was saving as nil  #user .new when ur creating an entry and .find paramsid when u have one and doing something to it

  	if @tripinput.save
  		redirect_to root_path, :notice => "A host will email #{Trip.last.email}!"  #change you to the email they just submitted Trip.last.email
  	else
  		render static_home_path #changed from redirect_to root_path because that loses all variables therefore loses the erro. changed render root_path, not sure why render root_path didn't work
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


  def checkout  #originally made this so that trips/checkout URL works  #show a cc form
    #grab a trip ID
    @trip = Trip.accepted.find_by_permalink(params[:id])    #only trips that have been accepted, so trips that havent been accepted nothing will show. accepted defined in trip.rb. it was Trip.accepted.find(params[:id]) can be anything
  end
  #http://localhost:3000/trips/fb309674c856b1792df628012825230344a610de/checkout


  def reserve  #JV told me to add this
    #button they click that submits the data
    @trip = Trip.find_by_permalink(params[:id])
    if @trip # If a trip is found

      # Create a customer to bill later with stripe
      customer = Stripe::Customer.create(
        :email => @trip.email,
        :card  => params[:stripeToken]
      )

      # Save stripe customer id into card_id 
      if @trip.update_attribute(:card_id, customer.id) # Card ID / Customer ID = Same same
        NotificationMailer.notifyhost(@trip).deliver # i added
        NotificationMailer.notifytraveller(@trip).deliver # i added
        redirect_to thanks_trip_path(@trip.permalink)
      else
        # Form failed
        render :checkout
      end
    else
      # This should never happen
      render text: "WHAT?"
    end
  end

  #because create was saving as nil
  private
  	def trip_params
    	params.require(:trip).permit(:email, :number_of_people, :city_id, :start_date)
  	end

    def stripe_params  #JV
      params.require(:trip).permit(:card_id)
    end

end
