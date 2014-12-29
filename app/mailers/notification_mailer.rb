class NotificationMailer < ActionMailer::Base
  default from: "from@example.com"

  def checkout(tripblah) #same name as the corresponding mailer view. @trip from controllers being passed into tripblach from accept
  	@trip = tripblah #mailer as the controller to its own view which is the email
  	# in the view you can go like <%= @trip.user_name %>
  	mail(to: @trip.email, subject: 'We found you a local')  #mail is function of actionmailer::base. it returns a mailable object, in trips controller under accept your calling deliver 
  end

end
