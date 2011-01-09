class ScheduleGenerator
  def self.calculate_pace(race_distance, time)
    race_distance  = race_distance * 1.0 #in case we get passed an integer

    time_in_seconds = Time.parse(time) - Time.now.beginning_of_day
    pace_in_seconds = time_in_seconds / race_distance

    Time.at(pace_in_seconds).gmtime.strftime('%M:%S')
  end

  def self.create_schedule(race_type, race_date, long_run_on_sunday=false)
    schedule = []

    mileage_lists = case race_type
      when Race::FIVE_K
        MileageLists::FIVE_K
      when Race::TEN_K
        MileageLists::TEN_K
      when Race::HALF_MARATHON
        MileageLists::HALF_MARATHON
      when Race::MARATHON
        MileageLists::MARATHON
      else
        MileageLists::FIVE_K
      end

    speed_training = case race_type
      when Race::FIVE_K
        SpeedTrainingLists::FIVE_K
      when Race::TEN_K
        SpeedTrainingLists::TEN_K
      when Race::HALF_MARATHON
        SpeedTrainingLists::HALF_MARATHON
      when Race::MARATHON
        SpeedTrainingLists::MARATHON
      else
        SpeedTrainingLists::FIVE_K
      end

    num_weeks = mileage_lists.size
    start_date = race_date - (num_weeks * 7)
    unless start_date >= Date.today
      raise(ArgumentError, "You need #{num_weeks} weeks of training.  Try a race date of #{Date.today + num_weeks * 7}")
    end

    mileage_lists.each_index do |i|
      schedule.push(TrainingWeek.new(
        mileage_lists[i],
        speed_training[i],
        (start_date + (i+1) * 7).monday,
        long_run_on_sunday
      ))
    end

    return schedule
  end
end
