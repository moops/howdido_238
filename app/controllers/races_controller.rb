class RacesController < ApplicationController
  # GET /races
  # GET /races.xml
  def index
    @races = Race.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @races }
    end
  end

  # GET /races/1
  # GET /races/1.xml
  def show
    @race = Race.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @race }
    end
  end

  # GET /races/new
  # GET /races/new.xml
  def new
    @race = Race.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @race }
    end
  end

  # GET /races/1/edit
  def edit
    @race = Race.find(params[:id])
  end

  # POST /races
  # POST /races.xml
  def create
    @race = Race.new(params[:race])

    respond_to do |format|
      if @race.save
        flash[:notice] = 'Race was successfully created.'
        format.html { redirect_to(@race) }
        format.xml  { render :xml => @race, :status => :created, :location => @race }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @race.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /races/1
  # PUT /races/1.xml
  def update
    @race = Race.find(params[:id])

    respond_to do |format|
      if @race.update_attributes(params[:race])
        flash[:notice] = 'Race was successfully updated.'
        format.html { redirect_to(@race) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @race.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /races/1
  # DELETE /races/1.xml
  def destroy
    @race = Race.find(params[:id])
    @race.destroy

    respond_to do |format|
      format.html { redirect_to(races_url) }
      format.xml  { head :ok }
    end
  end


  # POST /results/load
  def load
    race = Race.find(params[:id])
    first_name_index = params[:first_name_index].to_i - 1
    last_name_index = params[:last_name_index].to_i - 1
    city_index = params[:city_index].to_i - 1
    bib_index = params[:bib_index].to_i - 1
    div_index = params[:div_index].to_i - 1
    div_place_index = params[:div_place_index].to_i - 1
    overall_place_index = params[:overall_place_index].to_i - 1
    
    data_found = false
    params[:datafile].readlines.each do |l|
      line = l.split(' ')
      if data_found
        
        #create athlete
        a = Athlete.new
        a.first_name = line[first_name_index] if first_name_index
        a.last_name = line[last_name_index] if last_name_index
        a.city = line[city_index] if city_index
        a.save
        
        #create result
        r = Result.new
        r.athlete = a if a 
        r.race = race if race 
        r.overall_place = line[overall_place_index] if overall_place_index
        r.div = line[div_index] if div_index 
        r.div_place = line[div_place_index] if div_place_index
        r.bib = line[bib_index] if bib_index
        r.save
      end
      data_found = line[0] == '=====' unless data_found
    end

    respond_to do |format|
      format.html { redirect_to(races_url) }
      format.xml  { head :ok }
    end
  end
end
