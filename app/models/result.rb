class Result < ActiveRecord::Base
  belongs_to :race
  belongs_to :athlete
  
  attr_accessor :name
  
  def name
    "#{self.athlete.first_name} #{self.athlete.last_name}" 
  end
end
