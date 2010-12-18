class TrainingWeek
  attr_reader :training_days

  def initialize(mileage_list, speed_work, monday_starting_week)
    raise(ArgumentError, "You gave me some sort of crazy week with #{mileage_list.size} days") if mileage_list.size != 7

    @training_days = 7.times.collect do |n|
      day_of_week = monday_starting_week + n
      if day_of_week.wednesday?
        TrainingRun.new(day_of_week, mileage_list[n], TrainingRun::FARTLEK)
      else
        TrainingRun.new(day_of_week, mileage_list[n])
      end
    end
  end

  def mileage
    @training_days.inject(0) { |sum, tr| sum + tr.mileage }
  end
end
