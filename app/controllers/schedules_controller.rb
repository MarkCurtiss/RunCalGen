class SchedulesController < InheritedResources::Base
  def create
    @schedule = Schedule.new(params[:schedule])

    if @schedule.valid?
      flash[:notice] = 'Schedule was successfully created'
      send_file(@schedule.to_file, :filename => @schedule.filename, :type => 'text/calendar')
    else
      render :action => 'new'
    end
  end
end
