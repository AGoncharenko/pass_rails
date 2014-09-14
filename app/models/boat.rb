class Boat < ActiveRecord::Base
  has_many :assignments, :dependent => :destroy
  has_many :timeslots, through: :assignments
end
