module MileageLists
  FIVE_K = [
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
      [ 0, 3, 3, 2, 2, 0, 3, ],
    ]

    TEN_K = [
      [ 0, 3, 4, 2, 0, 6, 3,  ],
      [ 0, 3, 4, 2, 0, 8, 3,  ],
      [ 0, 3, 4, 2, 2, 8, 2,  ],
      [ 0, 3, 4, 3, 2, 0, 10, ],

      [ 0, 4, 4, 4, 0, 8, 4, ],
      [ 0, 4, 4, 4, 4, 3, 5, ],
      [ 0, 4, 4, 4, 0, 8, 4, ],
      [ 0, 4, 4, 4, 3, 0, 7, ],

      [ 0, 4, 4, 3, 0, 8, 2, ],
      [ 0, 3, 5, 4, 3, 0, 5, ],
      [ 0, 4, 4, 3, 0, 6, 3, ],
      [ 0, 3, 4, 3, 2, 0, 6, ],
    ]
end

class ScheduleGenerator
  def self.calculate_pace(race_distance, time)
    race_distance  = race_distance * 1.0 #in case we get passed an integer

    time_in_seconds = Time.parse(time) - Time.now.beginning_of_day
    pace_in_seconds = time_in_seconds / race_distance

    Time.at(pace_in_seconds).gmtime.strftime('%M:%S')
  end

  def self.create_schedule(race_type, race_date)
    start_date = race_date - (12 * 7)
    unless start_date >= Date.today
      raise(ArgumentError, "You need 12 weeks of training.  Try #{Date.today + 12 * 7}")
    end

    schedule = []

    mileage_lists = case race_type
      when Race::FIVE_K
        MileageLists::FIVE_K
      when Race::TEN_K
        MileageLists::TEN_K
      else
        MileageLists::FIVE_K
      end

    mileage_lists.each_index do |i|
      schedule.push(TrainingWeek.new(
        mileage_lists[i],
        TrainingRun::FARTLEK,
        (start_date + (i+1) * 7).monday
      ))
    end

    return schedule
  end
end
