class Transport < ActiveRecord::Base
	has_many :wagons ,:dependent =>  :destroy
	has_many :items , :through => :wagons , :uniq => true , :dependent => :destroy, 
	:before_add => :check_before_add_remove, :before_remove => :check_before_add_remove
	
	#has_and_belongs_to_many :transports , :uniq => true
	#has_and_belongs_to_many :items  , :uniq => true
	belongs_to :loadPlace,   :class_name => "Place"
  belongs_to :unLoadPlace, :class_name => "Place"
  #accepts_nested_attributes_for :wagons
 
  before_save :check_before_save
   
    
  ######### pagination promenne	
  cattr_reader :per_page
  @@per_page = 25
  ######################
  
  
  protected 
    
  def check_before_add_remove(item)
    raise "Transport is finished - you can not add/remove item" unless  self.efectiveUnLoadTime.nil?	
   end 
  
		def check_before_save()	
  	# projde vsechny prepravy a jejich item a tam upravi place_id protoze uzavrenim prepravy se material presunul
  	#raise "zmena datumu"	if self.efectiveUnLoadTime_changed?
		  if  self.efectiveUnLoadTime_changed? and  not self.efectiveUnLoadTime.nil? then 
				#raise "zmena casu transportu unload"
				self.items.each do |item|
					if item.placeSince.nil?  then
						item.place_id = self.unLoadPlace.id
						item.placeSince = self.efectiveUnLoadTime 
						item.save						
					else 
						if item.placeSince <  self.efectiveUnLoadTime then
							item.place_id = self.unLoadPlace.id
							item.placeSince = self.efectiveUnLoadTime 
							item.save
						end	
					end	
				end	
		  end	
		end 
  

  
end
