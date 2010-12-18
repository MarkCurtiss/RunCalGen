require 'spec_helper'

describe ScheduleGenerator do
  describe '#calculate_pace' do
    it 'should determine pace given a race distance and a time' do
      ScheduleGenerator.calculate_pace('10K', '00:53:56').should == '8:40'
    end
  end
end
