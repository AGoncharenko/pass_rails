module TimeslotsHelper
  def unix_date(date)
    date_range = {}
    if date.present?
      date_range[:beginning_of_day] = date.to_datetime.to_i
      date_range[:end_of_day] = date.to_datetime.end_of_day.to_i
    end
    return date_range
  end
 end
