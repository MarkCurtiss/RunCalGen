require 'spec_helper'

describe Calendar do
  before(:each) do
    Timecop.freeze(Date.new(2010, 7, 7))
    @race_date = Date.new(2010, 12, 26)
    @schedule = ScheduleGenerator.create_schedule(Race::HALF_MARATHON, @race_date, false)
  end

  after(:each) { Timecop.return }

  describe '#initialize' do
    it 'should initialize from a schedule' do
      cal = Calendar.new(@schedule)

      last_event = cal.events.last
      last_event.start_time.should == @race_date
      last_event.summary.should == '13 miles'
    end

    it 'should not include off days' do
      cal = Calendar.new(@schedule)

      first_event = cal.events.first
      #skip the 'Off' on the 4th
      first_event.start_time.should == Date.new(2010, 10, 5)
      first_event.summary.should == '2 miles'
    end
  end

  describe '#write_ical_file' do
    it 'should write the calendar to an iCal file' do
      obj_cal = Calendar.new(@schedule)

      filename = '/tmp/half_marathon.ics'
      File.unlink(filename) if File.exists?(filename)
      components = RiCal.parse(
        File.open(obj_cal.write_ical_file(filename))
      )
      file_cal = components[0]

      file_cal.events.should == obj_cal.events
    end
  end
end
