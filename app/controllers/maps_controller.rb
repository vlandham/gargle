class MapsController < ApplicationController
  # GET /maps
  # GET /maps.xml
  def index
    if user_signed_in?
      @maps = current_user.maps.all
    else
      @maps = []
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @maps }
    end
  end

  # GET /maps/1
  # GET /maps/1.xml
  def show
    
    marker_num = 6
    @map = Map.find(params[:id])
    
    @map_view = GMap.new("map")
    @map_view.control_init(:large_map => true, :map_type => true, :scale => true)
    @map_view.interface_init(:dragging => true, :scroll_wheel_zoom => true)
    @map_view.center_zoom_init([38.890498,-94.818192], 9)
    
    @path_sets = @map.path_sets
    
    point_group = {}
      @path_sets.each_with_index do |path_set, index|
      
      marker_index = ( index % marker_num ) + 1 
        
      marker_name = "marker#{marker_index}"
      
      @map_view.icon_global_init( GIcon.new( :image => "/images/markers/#{marker_name}.png",  :icon_size => GSize.new( 32,32 ), :icon_anchor => GPoint.new(16,32), :info_window_anchor => GPoint.new(9,2), :shadow_size => GSize.new(37, 32) ), marker_name)
      icon = Variable.new(marker_name)
        
        path_set.paths.each do |path|
          unless path.point.nil?
            point_group[path.point.id] = path.point.to_marker( icon )
            if point_group.size == 1
              @map_view.center_zoom_init(path.point.location, 9)
            end
          end           
        end
      end

    @map_view.overlay_global_init(GMarkerGroup.new(true, point_group), "marker_group")


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
    @map.user = current_user

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
      format.html { redirect_to(root_path) }
      format.xml  { head :ok }
    end
  end
end
