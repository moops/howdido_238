# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)

athletes = Athlete.create([
    {:first_name => 'Adam', :last_name => 'Lawrence', :city => 'Victoria'},
    {:first_name => 'Mark', :last_name => 'Ritchie', :city => 'Victoria'},
    {:first_name => 'Allan', :last_name => 'Boos', :city => 'Victoria'},
    {:first_name => 'Marcus', :last_name => 'Durrant', :city => 'Sidney'},
    {:first_name => 'Bertrand', :last_name => 'Bozek', :city => 'Saanich'},
    {:first_name => 'Gary', :last_name => 'Duncan', :city => 'Victoria'}])

races = Race.create([
    {:race_on => '2009-07-12', :name => 'Tri of Compassion', :location => 'Esquimalt'},
    {:race_on => '2009-06-16', :name => 'Chemainus Twilight Shuffle', :location => 'Chemainus'}])

results = Result.create([
    # mark in compassion tri
    {:athlete => athletes[1], :race => races[0], :overall_place => 24, :bib => '235', :div => 'M4049', :div_place => 4},
    # allan in compassion tri
    {:athlete => athletes[2], :race => races[0], :overall_place => 1, :bib => '110', :div => 'M3039', :div_place => 1},
    # marcus in compassion tri
    {:athlete => athletes[3], :race => races[0], :overall_place => 14, :bib => '146', :div => 'M5059', :div_place => 3},
    # bertrand in compassion tri
    {:athlete => athletes[4], :race => races[0], :overall_place => 10, :bib => '111', :div => 'M3039', :div_place => 4},
    # mark in chemainus
    {:athlete => athletes[1], :race => races[1], :overall_place => 19, :bib => '746', :div => 'M4049', :div_place => 7},
    # gary in chemainus
    {:athlete => athletes[5], :race => races[1], :overall_place => 19, :bib => '193', :div => 'M4049', :div_place => 7}])



