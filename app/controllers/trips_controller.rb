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


  def charge #~~host hits charge on users who have 'paid'

  #@charge_guid_entered = Trip.new(charge_params)



  @entered = params[:entered]
   

   @trip = Trip.find(params[:id])



   if @entered == @trip.charge_guid

    begin  #like if else but crashes whole application and 'rescuse it'. when stripe charge create fails it doesnt return a value, it blows up. so you need a rescue. it handles error being thrown.
      stripe_response = Stripe::Charge.create(  #stripe_response is arbitrary variable, just for charge_id
        :amount => 999, # in cents
        :currency => "usd",
        :customer => @trip.card_id  
        )


    #***ADD the code for if GUID matches what's stored, then charge action happens
    #@charge_guid_entered = Trip.new(charge_params)
    #if @charge_guid_entered == Trip.charge_guid
      #charge em
    #else
      #don't charge em



      #@trip.charged_at = Time.now
      @trip.complete_code = stripe_response.id
      @trip.save
      #the above two require that you add 2 columns to trips table: charged_at (datetime)

      render text: 'success, you charged them'
      

    # Do your success here
    rescue Exception => e
      render text: 'failed'

    # Do your failure here

    end



  else
    render text: 'You entered the wrong receipt code'
  end





    #the following wouldve worked except for the render piece. 
    #@trip = Trip.find(params[:id])  #~~~??? why not @trip = Trip.find_by_permalink(params[:id])

    #@response = Stripe::Charge.create(
    # :amount => 999, # in cents
    # :currency => "usd",
    # :customer => @trip.card_id  
    # )
    #render static_home_path, :notice => "You just charged #{Trip.last.email} $9.99!"
    #above must be removed because you dont have the variables. all the varaibles need to be in this action








   #GRAB COMPLETE_CODE (somehow?) Trip.complete_code
    #if @trip.update_attribute(:complete_code, customer.id)

    #render static_home_path, :notice => "You just charged #{Trip.last.email} $9.99!"
    #above must be removed because you dont have the variables. all the varaibles need to be in this action
    #render static_home_path, :notice => "You just charged #{Trip.last.email} $9.99!"


    #else redirect_to :back, :notice => "Something failed. They weren't charged."
  end

#pass trip object (trip.find) into mailer

  #whats the checkout action for again?
  def checkout  #originally made this so that trips/checkout URL works  #show a cc form
    #grab a trip ID
    @trip = Trip.accepted.find_by_permalink(params[:id])    #only trips that have been accepted, so trips that havent been accepted nothing will show. accepted defined in trip.rb. it was Trip.accepted.find(params[:id]) can be anything
  end
  #8


  def reserve  #JV told me to add this
    #button they click that submits the data
    #ADDS card ID
    @trip = Trip.find_by_permalink(params[:id])  #is this line so that they have to access the page via a permalink?
    if @trip # If a trip is found

      # Create a customer to bill later with stripe
      customer = Stripe::Customer.create(
        :email => @trip.email,
        :card  => params[:stripeToken]
      #customer => trip.card_id
      )

      #***generate the charge GUID and store it
      @trip.add_charge_guid(current_user)  #this should generate and add a charge_guid when the user enters their card info. this charge_guid should be emailed to them as a part of their receipt.


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

    #def charge_params 
    #  params.require(:trip).permit(:charge_guid)
    #end

end
