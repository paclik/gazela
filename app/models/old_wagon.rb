class Wagon < ActiveRecord::Base
	belongs_to :item 
	belongs_to :transport
	#accepts_nested_attributes for :items
	#accepts_nested_attributes for :transports
	
	

end 
