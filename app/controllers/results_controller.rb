class ResultsController < ApplicationController
  # GET /results
  # GET /results.xml
  def index
    if params[:race_id]
      @results = Race.find(params[:race_id]).results
    else 
      @results = Result.all
    end
 
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @results }
    end
  end

  # GET /results/1/2.xml - race_id and athlete_id
  # GET /results/1 - result_id
  # GET /results/1.xml
  def show
    if params[:race_id] and params[:athlete_id]
      @result = Result.find(:first, :conditions => { :race_id => params[:race_id], :athlete_id => params[:athlete_id] })
    else
      @result = Result.find(params[:id])
    end

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @result.summary_xml }
    end
  end

  # GET /results/new
  # GET /results/new.xml
  def new
    @result = Result.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @result }
    end
  end

  # GET /results/1/edit
  def edit
    @result = Result.find(params[:id])
  end

  # POST /results
  # POST /results.xml
  def create
    @result = Result.new(params[:result])

    respond_to do |format|
      if @result.save
        flash[:notice] = 'Result was successfully created.'
        format.html { redirect_to(@result) }
        format.xml  { render :xml => @result, :status => :created, :location => @result }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @result.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /results/1
  # PUT /results/1.xml
  def update
    @result = Result.find(params[:id])

    respond_to do |format|
      if @result.update_attributes(params[:result])
        flash[:notice] = 'Result was successfully updated.'
        format.html { redirect_to(@result) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @result.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /results/1
  # DELETE /results/1.xml
  def destroy
    @result = Result.find(params[:id])
    @result.destroy

    respond_to do |format|
      format.html { redirect_to(results_url) }
      format.xml  { head :ok }
    end
  end

  # POST /results/load
  def load

    race = Race.find(params[:race_id])
    first_name_index = params[:first_name_index].to_i unless params[:first_name_index].empty?
    last_name_index = params[:last_name_index].to_i unless params[:last_name_index].empty?
    city_index = params[:city_index].to_i unless params[:city_index].empty?
    bib_index = params[:bib_index].to_i unless params[:bib_index].empty?
    div_index = params[:div_index].to_i unless params[:div_index].empty?
    overall_place_index = params[:overall_place_index].to_i unless params[:overall_place_index].empty?
    gun_time_index = params[:gun_time_index].to_i unless params[:gun_time_index].empty?
    chip_time_index = params[:chip_time_index].to_i unless params[:chip_time_index].empty?
    penalty_time_index = params[:penalty_time_index].to_i unless params[:penalty_time_index].empty?
    age_index = params[:age_index].to_i unless params[:age_index].empty?
    if params[:div_place_index].empty?
      div_places = Hash.new
    else
      div_place_index = params[:div_place_index].to_i
    end 

    data_found = false
    params[:datafile].readlines.each do |l|
      line = l.split(' ')
      if data_found
        first_name = line[first_name_index].downcase
        last_name = line[last_name_index].downcase
        #find and update or create athlete
        a = Athlete.find_by_first_name_and_last_name(first_name, last_name)
        unless a
          a = Athlete.new
          a.first_name = first_name
          a.last_name = last_name
        end
        #set age
        if age_index
          a.birth_date = race_on << (line[age_index].to_i.*12)
        end
        a.city = line[city_index] if city_index
        if div_index
          a.guess_gender(line[div_index])
          a.guess_birth_date(race.race_on, line[div_index]) unless age_index
        end
        a.save
        
        #create result
        r = Result.new
        r.athlete = a if a 
        r.race = race if race 
        r.overall_place = line[overall_place_index] if overall_place_index
        r.div = line[div_index] if div_index 
        # use or calculate div_place
        if div_place_index
          r.div_place = line[div_place_index]
        else
          if r.div
            place = (div_places.has_key?(r.div) ? div_places[r.div] + 1 : 1)
            r.div_place = place
            div_places[r.div] = place
          end
        end 
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
      time += (p.to_i * (60**i))
    end
    time
  end

end
