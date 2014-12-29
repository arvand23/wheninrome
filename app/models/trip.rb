class Trip < ActiveRecord::Base
	belongs_to :city

	def self.accepted; where('accepted_at IS NOT NULL'); end
	def self.unaccepted; where('accepted_at IS NULL'); end
	def self.undeclined; where('declined_at IS NULL'); end #need to change so its declined only by that specific user
	def self.past; where('start_date < :nowminustwo', :nowminustwo => Time.now - 2.days); end #didn't test this to see if it works
	def self.unresponded; unaccepted.undeclined; end


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
