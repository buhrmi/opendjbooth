class BoothsController < ApplicationController
  def show
    booth = Booth.find(params[:id])
    if params[:date]
      date = Time.parse(params[:date])
    else
      date = Time.now.beginning_of_day
    end
      
    slots = booth.slots.on_day(date)
    
    @description = date.strftime('%A, %B %e, %Y')
    
    render inertia: 'booths/show', props: {
      booth: booth,
      date: date,
      slots: slots.as_json(Slot::PUBLIC_OPTIONS)
    }
  end

  def index
    render inertia: 'booths/index', props: {
      booths: Booth.all
    }
  end

end