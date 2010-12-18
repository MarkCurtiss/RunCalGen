class ScheduleGenerator
  def self.calculate_pace(race_distance, time)
    race_distance  = race_distance * 1.0 #in case we get passed an integer

    (seconds, minutes, hours) = Time.parse(time).to_a[0..2]
    time_in_seconds = seconds + (minutes * 60) + (hours * 60 * 60)
    pace_in_minutes = (time_in_seconds / race_distance) / 60

    pace_minutes = pace_in_minutes.to_i
    pace_seconds = ((pace_in_minutes - pace_in_minutes.to_i) * 60).to_i

    "%d:%02d" % [ pace_minutes, pace_seconds ]
  end
end
