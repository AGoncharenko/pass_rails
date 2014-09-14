class Timeslot < ActiveRecord::Base
  has_many :assignments, :dependent => :destroy
  has_many :bookings, :dependent => :destroy
  has_many :boats, through: :assignments
  accepts_nested_attributes_for :boats

  def availability!
    boats = self.boats.order("capacity asc")
    biggest_boat = boats[-1]
    smaller_boat = boats[-2]
    max_boat_capacity = biggest_boat.capacity
    smaller_boat_capacity = smaller_boat.capacity if !smaller_boat.nil?
    max_party = max_boat_capacity - self.customer_count
    if smaller_boat.present? && smaller_boat_capacity > max_party
      max_party = smaller_boat_capacity
    end
    self.availability = max_party
    self.save!
  end

  def timeslot_xing!
    time_range = (self.start_time..self.end_time!).to_a

    current_timeslot_boats = self.boats
    timeslots = Timeslot.where.not(id: self.id)
    timeslots.each do |timeslot|
      if time_range.include?(timeslot.end_time!)
        timeslot.boats.each do |boat|
          if self.boats.include?(boat)
            timeslot.availability = 0
            timeslot.save!
          end
        end
      end
    end

  end

  def end_time!
    self.start_time + self.duration*60
  end
end
