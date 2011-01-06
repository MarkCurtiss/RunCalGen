class Schedule
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :race_type, :race_date, :calendar

  validates_presence_of :race_type, :race_date

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end

    unless attributes.empty?
      self.race_date = Date.parse(attributes[:race_date])
      self.race_type = race_type.to_f
      schedule = ScheduleGenerator.create_schedule(self.race_type, self.race_date)
      self.calendar = Calendar.new(schedule)
    end
  end

  def persisted?
    false
  end

  def filename
    "#{Race::RACE_TYPES[race_type]}_schedule_for_#{race_date}.ics"
  end

  def to_file
    self.calendar.write_ical_file(Tempfile.new('schedule'))
  end
end
