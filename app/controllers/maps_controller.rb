class MapsController < ApplicationController
  # GET /maps
  # GET /maps.xml
  def index
    @maps = Map.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @maps }
    end
  end

  # GET /maps/1
  # GET /maps/1.xml
  def show
    @map = Map.find(params[:id])
    
    @map_view = GMap.new("map_div")
    @map_view.control_init(:large_map => true,:map_type => true)
    @map_view.center_zoom_init([75.5,-42.56],4)
    @map_view.overlay_init(GMarker.new([75.6,-42.467],:title => "Hello", :info_window => "Info! Info!"))

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @map_info }
    end
  end

  # GET /maps/new
  # GET /maps/new.xml
  def new
    @map = Map.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @map }
    end
  end

  # GET /maps/1/edit
  def edit
    @map = Map.find(params[:id])
  end

  # POST /maps
  # POST /maps.xml
  def create
    @map = Map.new(params[:map])

    respond_to do |format|
      if @map.save
        flash[:notice] = 'Map was successfully created.'
        format.html { redirect_to(@map) }
        format.xml  { render :xml => @map, :status => :created, :location => @map }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @map.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /maps/1
  # PUT /maps/1.xml
  def update
    @map = Map.find(params[:id])

    respond_to do |format|
      if @map.update_attributes(params[:map])
        flash[:notice] = 'Map was successfully updated.'
        format.html { redirect_to(@map) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @map.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /maps/1
  # DELETE /maps/1.xml
  def destroy
    @map = Map.find(params[:id])
    @map.destroy

    respond_to do |format|
      format.html { redirect_to(maps_url) }
      format.xml  { head :ok }
    end
  end
end