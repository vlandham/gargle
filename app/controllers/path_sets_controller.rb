class PathSetsController < ApplicationController
  
  def new
    
    @map = Map.find(params[:map_id])
    @path_set = PathSet.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @path_set }
    end
  end

  # POST /path_sets
  def create
    @map = Map.find(params[:map_id])
    
    if !params || !params[:dump] || !params[:dump][:file]
      flash[:notice] = "Error: We need an Import File"
      redirect_to map_path(@map)
      return
    end
    
    @path_set = PathSet.new
    
    name = params[:dump][:name]
    name = "default" unless name
    
    @path_set.name = name
    
    latitude_index = params[:dump][:latitude].to_i - 1
    longitude_index = params[:dump][:longitude].to_i - 1
    description_index = params[:dump][:description].to_i - 1
    
    count = 0
    
    params[:dump][:file].each_with_index do |line, index|        
        next unless line.chomp.length > 0
        columns = line.split(',')
        if( latitude_index >= columns.size  || longitude_index >= columns.size  )
          flash[:notice] = "Error: Invalid lat / lon indices!"
          redirect_to map_path(@map)
          return
        end
        
        lat_value = columns[latitude_index].strip
        lon_value = columns[longitude_index].strip
        
        
        if( !lat_value.empty? && !lon_value.empty?)
          lat_value = lat_value.to_i
          lon_value = lon_value.to_i
          description = ""
          
          if( description_index < columns.size )
            description = columns[description_index]
          end
          
   
          point = Point.new
          point.lat = lat_value
          point.lon = lon_value
          point.description = description unless description.empty?
        
          point_path = Path.create
          point_path.point = point
          @path_set.paths << point_path
          count += 1
        end

    end
    
    @map.path_sets << @path_set

    respond_to do |format|
      if @path_set.save && @map.save
        flash[:notice] = "Import successful! #{count} waypoints created"
        format.html { redirect_to map_url(@map) }
        format.xml  { render :xml => @path_set, :status => :created, :location => @path_set }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @path_set.errors, :status => :unprocessable_entity }
      end
    end
  end
end