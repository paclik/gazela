class WagonsController < ApplicationController
	
  before_filter :require_admin, :only => [:new,  :edit, :update,  :destroy, :create]
  before_filter :require_user, :only => [ :show, :index]
	
	#navigation :wagons
  # GET /wagons
  # GET /wagons.xml
  def index
   	## @wagons = Wagon.all
   	@wagons = Wagon.paginate :page => params[:page], :order => 'id DESC'
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @wagons }
    end
  end

  # GET /wagons/1
  # GET /wagons/1.xml
  def show
    @wagon = Wagon.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @wagon }
    end
  end

  # GET /wagons/new
  # GET /wagons/new.xml
  def new
    @wagon = Wagon.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @wagon }
    end
  end

  # GET /wagons/1/edit
  def edit
    @wagon = Wagon.find(params[:id])
  end

  # POST /wagons
  # POST /wagons.xml
  def create
    @wagon = Wagon.new(params[:wagon])

    respond_to do |format|
      if @wagon.save
        flash[:notice] = 'Wagon was successfully created.'
        format.html { redirect_to(@wagon) }
        format.xml  { render :xml => @wagon, :status => :created, :location => @wagon }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @wagon.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /wagons/1
  # PUT /wagons/1.xml
  def update
    @wagon = Wagon.find(params[:id])

    respond_to do |format|
      if @wagon.update_attributes(params[:wagon])
        flash[:notice] = 'Wagon was successfully updated.'
        format.html { redirect_to(@wagon) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @wagon.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /wagons/1
  # DELETE /wagons/1.xml
  def destroy
    @wagon = Wagon.find(params[:id])
    @wagon.destroy

    respond_to do |format|
      format.html { redirect_to(wagons_url) }
      format.xml  { head :ok }
    end
  end
end
