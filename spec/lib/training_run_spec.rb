require 'spec_helper'

describe TrainingRun do
  describe '#to_s' do
    it 'should stringify nicely' do
      TrainingRun.new(Date.new(2010, 12, 13), 8, TrainingRun::FARTLEK).to_s.should eql 'Monday: 8 miles (fartlek)'
    end

    it 'should understand off days' do
      TrainingRun.new(Date.new(2010, 12, 17)).to_s.should eql 'Friday: Off'
    end
  end
end
