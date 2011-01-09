class TrainingRun
  FARTLEK = 'fartlek'

  attr_reader :mileage, :day_of_week, :speed_training

  def initialize(day_of_week, mileage=0, speed_training=nil)
    @day_of_week = day_of_week
    @mileage = mileage
    @speed_training = speed_training
  end

  def activity
    "#{@mileage > 0 ? @mileage.to_s + ' miles': 'Off'}" +
    "#{@speed_training && ! @speed_training.empty? ? ' (' + @speed_training + ')' : ''}"
  end

  def to_s
    "#{@day_of_week.strftime('%A')}: " + self.activity
  end
end
