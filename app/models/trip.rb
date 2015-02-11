class Trip < ActiveRecord::Base
	belongs_to :city
	belongs_to :user
	validates :email, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i}
	#add this to email validation    
	validate :start_date_in_future?

	def start_date_in_future?
    	unless Date.today < self.start_date
    		errors.add(:start_date, 'Not in future')  #need error message and which field your adding the error to when youc reate a custom validation
    	end
  	end

	def self.accepted; where('accepted_at IS NOT NULL'); end
	def self.unaccepted; where('accepted_at IS NULL'); end
	def self.undeclined; where('declined_at IS NULL'); end #need to change so its undeclined only by that specific user
	def self.past; where('start_date < :nowminustwo', :nowminustwo => Time.now - 2.days); end #didn't test this to see if it works
	def self.unresponded; unaccepted.undeclined; end #no one has accepted and no one has declined these people
	def self.paid; where('card_id IS NOT NULL'); end #need to change so that its accepted by that specific user and card is not null

	def generate_permalink
 		Digest::SHA1.hexdigest("#{Time.now} - #{self.id} - #{self.email}")
  	end


	def accept!(userblah) #exclamation point just cuz
  		self.accepted_at = Time.now  #the time right now
  		self.user_id = userblah.id #??why isnt the syntax current_user_id or something, id itself isnt an attribute ###cuz your passing an atrribute
  		self.permalink = generate_permalink
  		self.save
  	end






end
