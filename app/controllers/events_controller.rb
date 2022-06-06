class EventsController < ApplicationController
  def show
    event = Event.find(params[:id])
    render inertia: 'events/show', props: {
      event: event,
      slots: event.slots.as_json(include: :dj)
    }
  end

  def index
    render inertia: 'events/index'
  end

end