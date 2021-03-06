class ItemsController < ApplicationController
  require "fastercsv"
	
	# GET /items
  # GET /items.xml

  before_filter :require_admin, :only => [:new,  :edit, :update,  :destroy, :create]
  before_filter :require_user, :only => [ :show, :index]
  
  #navigation :items
  
 #Coil no.;AMB no.;SAP Order;ATL order;Mill;customer;customer ref;Part no.;steel grade;thickness;width;gross weight;netweight
#verze01 souborcsv je načten 
def uploadfile
    ##render :file => 'app\views\upload\uploadfile.html.erb'
end

def savefile
    # parse the csv file using ruby "csv"-librarty
    @notice = ""
     
    unless params[:upload].nil?
    	parser = FasterCSV.read(params[:upload][:datafile].path,:col_sep => ";", :headers => true)
    else 
    	redirect_to :action => 'index'
    	return
    end	
  
    parser.each do |row|
    
			if Item.find(:first, :conditions => [ "itemid= ?", row["Pipe No & Group No"]]) 
				#i.storno = true
				@notice  += row["Pipe No & Group No"] + "duplicated" + "  XXXX  "
			else
				 i=Item.new	
				 if Transport.find(:first, :conditions => [ "vrn= ?", row["Train No"]])  then
				 	 @transportid = Transport.find(:first, :conditions => [ "vrn= ?", row["Train No"]])
				 else
				 	 @transportid = Transport.create(:vrn =>  row["Train No"], :loadPlace_id => Place.find_or_create_by_name(:name => row["Loading Location"]).id ,
				 	 	 :senderRequest =>  row["Loading Location"] +"-"+ row["Destination"] +"-"+ row["Train No"],
				 	 	 :unLoadPlace_id => Place.find_or_create_by_name(:name => row["Destination"]).id, 
				 	 	 :loadTime => DateTime.strptime(row["Loading date"],'%d.%m.%Y'), :effectiveLoadTime => DateTime.strptime(row["Departure Date"],'%d.%m.%Y'),
				 	 	 :UnLoadTime => DateTime.strptime(row["Pardubice rst."],'%d.%m.%Y') )
			 	 end
			 	 
				 i=Item.new	
				 i.transports << @transportid
				 i.wagons.find_by_transport_id(@transportid).update_attributes(:vrn => row["Equipment No"], :wag_type => "train")
				 i.itemid = row["Pipe No & Group No"]
				 #i.amb = row["Equipment No"]
				 #i.sap = row["SAP Order"]
				 #i.atl = row["ATL order"]
				 #i.customerorder = row["customer ref"]
				 #i.mill = row["Mill"]
				 #i.partnumber = row["Part no."]  
				 i.width = row["width"]  
				 #i.customer = row["customer"]  
				 i.length = 18.0  
				 i.weight = row["Gross weight"].gsub(",", ".") 
				 #i.netweight = row["netweight"].gsub(",",".") 
				 #i.thickness = row["thickness"].gsub(",", ".")
				 #i.pieces = 1 
				 if not i.save 
						@notice  += "product " + row["Coil no."] + "was not saved " + "  XXXX  "
				 end	
			 end 
    end
    flash[:notice] = @notice
    redirect_to :action => 'index'
end
  
  
  def unlink
  	@item = Item.find(params[:id])
  	begin
  		@transport = Transport.find(params[:transport])
  		@item.transports.delete(Transport.find(params[:transport])) 
  	rescue Exception => e  
   		flash[:notice] = e.message 
  	end	
  	redirect_to :action => 'edit'
  end
  
  
  def index
 
      if params[:place_id] then @cond = [ "place_id = ? ", params[:place_id]] else @cond = ""end
     	# @items = Item.find(:all,:conditions => @cond,:order =>"id desc") 
     	@items = Item.paginate :page => params[:page],:conditions => @cond, :order => 'id DESC'
      respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @items }
    end
  end

  # GET /items/1
  # GET /items/1.xml
  def show
    @item = Item.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @item }
    end
  end

  # GET /items/new
  # GET /items/new.xml
  def new
    @item = Item.new
    @transports = Transport.find(:all,:conditions => "effectiveLoadTime IS NULL and efectiveUnloadTime IS NULL  ")
    #@transports = Transport.find(:all)
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @item }
    end
  end

  # GET /items/1/edit
  def edit
    @item = Item.find(params[:id])
    unless @item.place_id.nil?  then
    	@cond1 = "and loadPlace_id = #{@item.place_id} " 
    else
    	@cond1 = " "
    end	
    #@transports = Transport.find(:all,:conditions => "effectiveLoadTime IS NULL and efectiveUnloadTime IS NULL #{@cond1} ")
    @transports = Transport.find(:all,:conditions => "effectiveLoadTime IS NULL and efectiveUnloadTime IS NULL")
    if @item.wagons.find(:last) then @wagon_vrn = @item.wagons.find(:last).vrn end
  end

  # POST /items
  # POST /items.xml
  def create
    @item = Item.create(params[:item])
    if (!params[:transport].blank? )	  then
     		@transport = Transport.find((params[:transport])) 
				begin
					@itemtransports = @item.transports << @transport
					@wagon = @itemtransports.find(@transport).wagons.find_by_item_id(@item)

					@wagon.vrn =  params[:wagon_vrn]
					@wagon.wag_type = "train"
					@wagon.save
				rescue Exception => e  
						flash[:notice] = e.message 
  			end	
		end	 
		respond_to do |format|
      if @item.save
        flash[:notice] = 'Item was successfully updated.' if flash[:notice] == ""
        format.html { redirect_to(@item) }
        format.xml  { render :xml => @item, :status => :created, :location => @item }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /items/1
  # PUT /items/1.xml
  def update
    @item = Item.find(params[:id])
    if (!params[:transport].blank?  and !@item.transports.exists?(params[:transport]))	  then
     		@transport = Transport.find((params[:transport])) 
				begin
					@itemtransports = @item.transports << @transport
					@wagon = @itemtransports.find(@transport).wagons.find_by_item_id(@item)
					@wagon.vrn =  params[:wagon_vrn]
					@wagon.wag_type = "train"
					@wagon.save
				rescue Exception => e  
						flash[:notice] = e.message 
  			end	
		end	
    respond_to do |format|
      if @item.update_attributes(params[:item]) 
        flash[:notice] = 'Item was successfully updated.' if flash[:notice] == ""
        format.html { redirect_to(@item) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.xml
  def destroy
    @item = Item.find(params[:id])
    @item.destroy

    respond_to do |format|
      format.html { redirect_to(items_url) }
      format.xml  { head :ok }
    end
  end
end
