# Configures your navigation
SimpleNavigation::Configuration.run do |navigation|  
 navigation.items do |primary|
  
 	 primary.item :items, 'Items',items_path  do |sub_nav|
 	 	 sub_nav.item :list, 'List', items_path 
     sub_nav.item :new, 'New', new_item_path
     sub_nav.item :upload, 'Upload', uploadfile_item_path
    	
    end 
    
    primary.item :transports, 'Transports',transports_path  do |sub_nav|
 	  sub_nav.item :list, 'List', :controller => 'transports', :action => 'index'
 	 	sub_nav.item :new, 'New', new_transport_path
   
    	                                                          
    end 

    primary.item :wagons, 'Wagons', wagons_path  do |sub_nav|
    	sub_nav.item :list, 'Přehled', :controller => 'wagons', :action => 'index'
    
    	
    	                                                          
    end 
    primary.item :placess, 'Places', places_path  do |sub_nav|
    	sub_nav.item :list, 'List', :controller => 'places', :action => 'index'
    	sub_nav.item :new, 'New', new_place_path
     	sub_nav.item :googlemap, 'Map', "http://maps.google.com/maps/ms?ie=UTF8&msa=0&msid=106887346557407090896.0004924923193cbfbbfdd&t=h&z=8"
    	
    	                                                          
    end 
 end 
  
end