json.array!(@timeslots) do |timeslot|
  json.(timeslot, :id, :start_time, :duration, :availability, :customer_count)
  json.boats timeslot.boats, :id
end