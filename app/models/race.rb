class Race < ActiveRecord::Base
  has_many :results
  has_many :athletes, :through => :results
end
