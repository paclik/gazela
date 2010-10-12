class ItemsController < ApplicationController
  # GET /items
  # GET /items.xml

  before_filter :require_admin, :only => [:new,  :edit, :update,  :destroy, :create]
  before_filter :require_user, :only => [ :show, :index]
  
  #navigation :items
  
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
