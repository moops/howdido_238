class Result < ActiveRecord::Base
  belongs_to :race
  belongs_to :athlete
end
