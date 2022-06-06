class EventsController < ApplicationController
  def show
    event = Event.find(params[:id])
    my_slot = Slot.find_by(event: event, dj: current_dj)
    render inertia: 'events/show', props: {
      event: event,
      slots: event.slots.as_json(include: :dj),
      my_slot: my_slot
    }
  end

  def index
    render inertia: 'events/index'
  end

end