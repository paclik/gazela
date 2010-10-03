class Place < ActiveRecord::Base
	has_many :transports 
	has_many :items
	belongs_to :state
	accepts_nested_attributes_for :items
	
	 ######### pagination promenne	
  cattr_reader :per_page
  @@per_page = 25
  ######################
  
end 
