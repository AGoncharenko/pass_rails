class Assignment < ActiveRecord::Base
  belongs_to :boat
  belongs_to :timeslot

 # validates_uniqueness_of :timeslot_id, scope: :boat_id
end
