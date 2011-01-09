class TrainingWeek
  attr_reader :training_days, :monday_starting_week

  def initialize(mileage_list, speed_training, monday_starting_week, long_run_on_sunday=false)
    raise(ArgumentError, "You gave me some sort of crazy week with #{mileage_list.size} days") if mileage_list.size != 7

    if long_run_on_sunday
      sunday_miles = mileage_list.last
      mileage_list[6] = mileage_list[5]
      mileage_list[5] = sunday_miles
    end

    @training_days = 7.times.collect do |n|
      day_of_week = monday_starting_week + n
      if day_of_week.wednesday?
        TrainingRun.new(day_of_week, mileage_list[n], speed_training)
      else
        TrainingRun.new(day_of_week, mileage_list[n])
      end
    end
  end

  def mileage
    @training_days.inject(0) { |sum, tr| sum + tr.mileage }
  end
end
