class Item < ActiveRecord::Base
	has_many :wagons ,:dependent => :destroy
	has_many :transports, :through => :wagons , :uniq => true, :before_add => :check_before_add, :before_remove => :check_before_remove
  belongs_to :place
 
  ######### pagination promenne	
  cattr_reader :per_page
  @@per_page = 50
  ######################
  
  protected 
  # zkontroluje pred tim nez odstrani spojeni v join tabulce
  def check_before_remove(transport)
  	# pokud je transport uzavřen vyvolam vyjímku
  	if not transport.efectiveUnLoadTime.nil?
  		raise "Transport is finished - you can not remove item" 
  	else
  		#Pokud jde o posledni transport daneho itemu vynuluju jeho Place_id
  		if self.transports.size == 1 then
  			self.place_id = nil
  			self.placeSince = nil
  			self.save
			end	
  	end	
   end 

   # zkontroluje pred tim nez prida spojeni v join tabulce
   def check_before_add(transport)
  	# pokud je transport uzavřen vyvolam vyjímku
  	if not transport.efectiveUnLoadTime.nil?
  		raise "Transport is finished - you can not add item" 
  	else
  		#Pokud nema Item place_id  je mu prirazeno nakladaci misto transportu jemuz je prirazen
  		if self.place_id.nil? then
  			self.place_id = transport.loadPlace_id
  			self.placeSince = transport.loadTime
  			self.save
			end	
  	end	
   end 
   
   

   
end
