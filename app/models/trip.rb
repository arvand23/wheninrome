class Trip < ActiveRecord::Base
	belongs_to :city
	has_one :reservation
end
