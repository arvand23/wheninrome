class Trip < ActiveRecord::Base
	belongs_to :city

	def self.unaccepted; where('accepted_at IS NULL'); end
	def self.undeclined; where('declined_at IS NULL'); end #need to change so its declined only by that specific user
	def self.past; where('start_date < :nowminustwo', :nowminustwo => Time.now - 2.days); end #didn't test this to see if it works
	def self.unresponded; unaccepted.undeclined.past; end

end
