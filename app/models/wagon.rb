class Wagon < ActiveRecord::Base
	belongs_to :item 
	belongs_to :transport
	
	 ######### pagination promenne	
  cattr_reader :per_page
  @@per_page = 20
  ######################
end 
