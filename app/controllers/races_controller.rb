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
    first_name_index = params[:first_name_index].to_i unless params[:first_name_index].empty?
    last_name_index = params[:last_name_index].to_i unless params[:last_name_index].empty?
    city_index = params[:city_index].to_i unless params[:city_index].empty?
    bib_index = params[:bib_index].to_i unless params[:bib_index].empty?
    div_index = params[:div_index].to_i unless params[:div_index].empty?
    div_place_index = params[:div_place_index].to_i unless params[:div_place_index].empty?
    overall_place_index = params[:overall_place_index].to_i unless params[:overall_place_index].empty?
    gun_time_index = params[:gun_time_index].to_i unless params[:gun_time_index].empty?
    chip_time_index = params[:chip_time_index].to_i unless params[:chip_time_index].empty?
    penalty_time_index = params[:penalty_time_index].to_i unless params[:penalty_time_index].empty?

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
        r.gun_time = get_time(line[gun_time_index]) if gun_time_index
        r.chip_time = get_time(line[chip_time_index]) if chip_time_index
        r.penalty_time = get_time(line[penalty_time_index]) if penalty_time_index
        r.save
      end
      data_found = line[0] == '=====' unless data_found
    end

    respond_to do |format|
      format.html { redirect_to(races_url) }
      format.xml  { head :ok }
    end
  end

  def get_time(time_string)
    time = 0
    parts = time_string.split(':')
    parts.reverse!
    parts.each_with_index do |p,i|
      logger.info('i: ' + i.to_s + ' time: ' + time.to_s + ' parts: ' + parts.inspect)
      part = parts[i]
      logger.info('part: ' + part.to_s + ' exponent: ' + (60**i).to_s + ' add: ' + (part * (60**(i-1))).to_s)
      time += (parts[i].to_i * (60**i))
    end
    time
  end
end
