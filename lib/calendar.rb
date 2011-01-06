class Calendar
  def initialize(schedule)
    @cal = RiCal.Calendar do
      schedule.each do |tw|
        tw.training_days.each do |td|
          event do
            summary    td.activity
            dtstart    td.day_of_week
            dtend      td.day_of_week
          end
        end
      end
    end
  end

  def events
    @cal.events
  end

  def write_ical_file(filename)
    File.open(filename, 'w') do |f|
      f.write(@cal.to_s)
      f.path
    end
  end
end
