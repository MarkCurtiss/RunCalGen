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

  def self.create_5k_schedule(race_date)
    start_date = race_date - (12 * 7)
    unless start_date >= Date.today
      raise(ArgumentError, "You need 12 weeks of training.  Try #{Date.today + 12 * 7}")
    end

    mileage_lists = [
      [ 0, 3, 3, 2, 0, 5, 2, ],
      [ 0, 3, 3, 2, 0, 5, 2, ],
      [ 0, 3, 3, 3, 0, 5, 3, ],
      [ 0, 3, 3, 3, 3, 0, 6, ],

      [ 0, 3, 3, 3, 0, 6, 3, ],
      [ 0, 4, 4, 3, 0, 6, 3, ],
      [ 0, 4, 4, 3, 0, 6, 3, ],
      [ 0, 4, 3, 4, 3, 0, 4, ],

      [ 0, 3, 4, 3, 0, 5, 3, ],
      [ 0, 3, 3, 2, 3, 0, 4, ],
      [ 0, 3, 4, 2, 0, 4, 2, ],
      [ 0, 3, 3, 2, 2, 0, 3, ]
    ]

    schedule = []
    mileage_lists.each_index do |i|
      schedule.push(TrainingWeek.new(
        mileage_lists[i],
        TrainingRun::FARTLEK,
        (start_date + (i+1) * 7).monday
      ))
    end

    schedule
  end
end
