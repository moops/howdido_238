class Race < ActiveRecord::Base
  has_many :results
  has_many :athletes, :through => :results
  
  def results_by_division
    h = Hash.new
    for r in results do
      h[r.div] = { "gun" => r.gun_time, "ath" => r.athlete.first_name }
    end
    h
  end
  
end
