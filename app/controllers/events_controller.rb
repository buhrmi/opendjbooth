class EventsController < ApplicationController
  def show
    event = Event.find(params[:id])
    @title = event.name + ' Lineup'
    
    @description = event.start_at.strftime('%A, %B %e, %Y')
    
    render inertia: 'events/show', props: {
      event: event,
      slots: event.slots.as_json(include: :dj)
    }
  end

  def index
    render inertia: 'events/index'
  end

end