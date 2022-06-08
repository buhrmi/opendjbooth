class EventsController < ApplicationController
  def show
    event = Event.find(params[:id])
    @title = event.name + ' timetable'
    
    @description = event.start_at.strftime('%A, %B %e, %Y')
    
    render inertia: 'events/show', props: {
      event: event,
      slots: event.slots.as_json(Slot::PUBLIC_OPTIONS)
    }
  end

  def index
    render inertia: 'events/index'
  end

end