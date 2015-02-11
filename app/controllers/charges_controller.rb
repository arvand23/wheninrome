class ChargesController < ApplicationController

	

	def create #create the actual charges

	  customer = Stripe::Customer.create(
	    :email => 'example@stripe.com',
	    :card  => params[:stripeToken]
	  )

	end


end
