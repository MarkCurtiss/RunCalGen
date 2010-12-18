class TrainingRun
  attr_reader :mileage

  FARTLEK = 'fartlek'

  def initialize(day_of_week, mileage=0, speed_training=nil)
    @day_of_week = day_of_week
    @mileage = mileage
    @speed_training = speed_training
  end

  def to_s
    "#{@day_of_week.strftime('%A')}: " + 
    "#{@mileage > 0 ? @mileage.to_s + ' miles': 'Off'}" + 
    "#{@speed_training ? ' (' + @speed_training + ')' : ''}"
  end
end

