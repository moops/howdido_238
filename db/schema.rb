# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20091221081853) do

  create_table "athletes", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "city"
    t.string   "gender"
    t.date     "birth_date"
    t.boolean  "accurate_birth_date", :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "races", :force => true do |t|
    t.date     "race_on"
    t.string   "name"
    t.string   "location"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "results", :force => true do |t|
    t.integer  "athlete_id"
    t.integer  "race_id"
    t.integer  "overall_place"
    t.integer  "gun_time"
    t.integer  "chip_time"
    t.integer  "penalty_time"
    t.string   "bib"
    t.string   "div"
    t.integer  "div_place"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
