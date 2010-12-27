require 'spec_helper'

describe TrainingWeek do
  let(:mileage_list) { [ 0, 3, 3, 2, 0, 5, 2 ] }
  let(:training_week) { TrainingWeek.new(mileage_list, TrainingRun::FARTLEK, Date.new(2010, 12, 13)) }

  it 'should compute total mileage for the week' do
    training_week.mileage.should == 15
  end

  it 'should automatically assign speed workouts to Wednesday' do
    training_week.training_days.map { |tr| tr.to_s }.should == [ 
      'Monday: Off',
      'Tuesday: 3 miles',
      'Wednesday: 3 miles (fartlek)',
      'Thursday: 2 miles',
      'Friday: Off',
      'Saturday: 5 miles',
      'Sunday: 2 miles'
    ]
  end

  it 'should assign the long run to sunday if instructed' do
    tw = TrainingWeek.new(mileage_list, TrainingRun::FARTLEK, Date.new(2010, 12, 13), true)

    tw.training_days.map { |td| td.mileage }.should == [ 0, 3, 3, 2, 0, 2, 5, ]
  end

  it 'should raise an exception if you give it too many days' do
    lambda { 
      TrainingWeek.new((1..20).to_a, TrainingRun::FARTLEK, Date.new(2010, 12, 13)) 
    }.should raise_exception(ArgumentError, 'You gave me some sort of crazy week with 20 days')
  end
end

