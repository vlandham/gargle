class PointsController < ApplicationController
  # GET /points/new
  # GET /points/new.xml
  def new
    
    @map = Map.find(params[:map_id])

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @point }
    end
  end

  # POST /points
  # POST /points.xml
  def create
    @map = Map.find(params[:map_id])
    @point = Point.new(params[:point])
    
    # assuming that this is for only user submitted points
    user_path_set = @map.path_sets.find_by_name("user")
    if user_path_set.nil?
      user_path_set = PathSet.create(:name => "user")
      @map.path_sets << user_path_set
      user_path_set.save!
    end
    point_path = Path.create
    user_path_set.paths << point_path
    
    point_path.point = @point

    respond_to do |format|
      if point_path.save && user_path_set.save && @point.save
        flash[:notice] = 'Point was successfully created.'
        format.html { redirect_to map_url(@map) }
        format.xml  { render :xml => @point, :status => :created, :location => @point }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @point.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /points/1
  # PUT /points/1.xml
  def update
    @point = Point.find(params[:id])

    respond_to do |format|
      if @point.update_attributes(params[:Point])
        flash[:notice] = 'Point was successfully updated.'
        format.html { redirect_to(@point) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @point.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /points/1
  # DELETE /points/1.xml
  def destroy
    @map = Map.find(params[:map_id])
    @point = @map.points.find(params[:id])
    @point.destroy

    respond_to do |format|
      format.html { redirect_to(map_url(@map)) }
      format.xml  { head :ok }
    end
  end 
end
