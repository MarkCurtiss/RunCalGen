class SchedulesController < InheritedResources::Base
  def create
    race_time = params.delete('ten_k_time')
    age = params[:schedule]["runner_age"].to_i
    runner_type = nil
    
    if (age > 19 && age < 35)
      runner_type = case race_time
        when '53:56' 
          'Basic Competitor'
        when '44:57'
          'Competitor'
        when '41:29'
          'Advanced Competitor'
        when '35:57'
          'Local Champion'
        when '31:44'
          'Semi-Elite'
      end
    else 
      abort("TOO OLD")
    end

    params['schedule[runner_type]'] = runner_type
    create!
  end
end
