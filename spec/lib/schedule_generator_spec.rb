require 'spec_helper'

describe ScheduleGenerator do
  describe '#calculate_pace' do
    it 'should determine pace for a 5k race' do 
      ScheduleGenerator.calculate_pace(Race::FIVE_K, '00:25:56').should == '8:20'
    end

    it 'should determine pace for a 5M race' do
      ScheduleGenerator.calculate_pace(5, '00:42:38').should == '8:31'
    end

    it 'should determine pace for a 10k race' do
      ScheduleGenerator.calculate_pace(Race::TEN_K, '00:53:56').should == '8:40'
    end

    it 'should determine pace for a 10M race' do
      ScheduleGenerator.calculate_pace(10, '1:29:20').should == '8:56'
    end

    it 'should determine pace for a half marathon' do
      ScheduleGenerator.calculate_pace(Race::HALF_MARATHON, '1:58:06').should == '9:00'
    end

    it 'should determine pace for a marathon' do
      ScheduleGenerator.calculate_pace(Race::MARATHON, '4:13:40').should == '9:40'
    end
  end


  describe '#create_5k_schedule' do
    it 'should create 3 months of training weeks for a 5k' do
      ScheduleGenerator.create_5k_schedule.map { |tw| tw.mileage }.should == [
        15, 15, 17, 18,
        18, 20, 20, 18,
        18, 15, 15, 13
      ]
    end
  end
end
