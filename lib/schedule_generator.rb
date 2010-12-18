class ScheduleGenerator
  def self.calculate_pace(race_distance, time)
    kilometers_to_miles = 0.621371192
    length_in_miles = case race_distance
      when '10K' then 10 * kilometers_to_miles
      else 1
    end

    (seconds, minutes, hours) = Time.parse(time).to_a[0..2]
    time_in_seconds = seconds + (minutes * 60) + (hours * 60 * 60)
    pace_in_minutes = (time_in_seconds / length_in_miles) / 60

    pace_minutes = pace_in_minutes.to_i
    pace_seconds = ((pace_in_minutes - pace_in_minutes.to_i) * 60).to_i

    "#{pace_minutes}:#{pace_seconds}"
  end
end
