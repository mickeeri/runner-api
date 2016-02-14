class Race < ActiveRecord::Base
  belongs_to :race_creator
  belongs_to :location
end
