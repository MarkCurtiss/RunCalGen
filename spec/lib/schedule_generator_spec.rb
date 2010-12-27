require 'spec_helper'

describe ScheduleGenerator do
  describe '#calculate_pace' do
    it 'should determine pace for a 5k race' do 
      ScheduleGenerator.calculate_pace(Race::FIVE_K, '00:25:56').should == '08:20'
    end

    it 'should determine pace for a 5M race' do
      ScheduleGenerator.calculate_pace(5, '00:42:38').should == '08:31'
    end

    it 'should determine pace for a 10k race' do
      ScheduleGenerator.calculate_pace(Race::TEN_K, '00:53:56').should == '08:40'
    end

    it 'should determine pace for a 10M race' do
      ScheduleGenerator.calculate_pace(10, '1:29:20').should == '08:56'
    end

    it 'should determine pace for a half marathon' do
      ScheduleGenerator.calculate_pace(Race::HALF_MARATHON, '1:58:06').should == '09:00'
    end

    it 'should determine pace for a marathon' do
      ScheduleGenerator.calculate_pace(Race::MARATHON, '4:13:40').should == '09:40'
    end
  end

  describe 'create_schedule' do
    before(:each) do
      Timecop.freeze(2010, 7, 1)
      @race_date = Date.new(2010, 12, 05)
    end

    after(:each) { Timecop.return }

    it 'should raise an exception if there is insufficient time until the race' do
      lambda { 
        ScheduleGenerator.create_schedule(Race::FIVE_K, Date.new(2010, 7, 8))
      }.should raise_exception(ArgumentError, 'You need 12 weeks of training.  Try 2010-09-23')
    end

    it 'should create 3 months of training weeks for a 5k' do
      ScheduleGenerator.create_schedule(Race::FIVE_K, @race_date).map { |tw| tw.mileage }.should == [
        15, 15, 17, 18,
        18, 20, 20, 18,
        18, 15, 15, 13,
      ]
    end

    it 'should create 3 months of training weeks for a 5k ending on the race date' do
      ScheduleGenerator.create_schedule(Race::FIVE_K, @race_date).map { |tw| tw.training_days.last.day_of_week.to_s }.should == [
        '2010-09-19',
        '2010-09-26',
        '2010-10-03',
        '2010-10-10',
        '2010-10-17',
        '2010-10-24',
        '2010-10-31',
        '2010-11-07',
        '2010-11-14',
        '2010-11-21',
        '2010-11-28',
        '2010-12-05'
      ]
    end

    it 'should let you specify whether the long runs are on sunday or saturday' do
      schedule = ScheduleGenerator.create_schedule(Race::HALF_MARATHON, @race_date, true)

      schedule.first.training_days.map { |tr| tr.mileage }.should == [ 0, 2, 4, 2, 0, 2,  8, ]
      schedule.last.training_days.map  { |tr| tr.mileage }.should == [ 0, 3, 4, 2, 2, 13, 0, ]
    end

    it 'should create 3 months of training weeks for a 10k' do
      ScheduleGenerator.create_schedule(Race::TEN_K, @race_date).map { |tw| tw.mileage }.should == [
        18, 20, 21, 22,
        24, 24, 24, 22,
        21, 20, 20, 18,
      ]
    end

    it 'should create 3 months of training weeks for a half-marathon' do
      ScheduleGenerator.create_schedule(Race::HALF_MARATHON, @race_date).map { |tw| tw.mileage }.should == [
        18, 20, 24, 27,
        30, 30, 26, 30,
        26, 25, 23, 24,
      ]
    end
  end
end
