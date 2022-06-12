class EventsController < ApplicationController
  def show
    event = Event.find(params[:id])
    redirect_to place_path(event.place, date: event.start_at.strftime('%Y-%m-%d'))
  end

  def index
    upcoming = Event.where('start_at > ?', Time.now - 12.hours)
    past = Event.where('start_at < ?', Time.now - 12.hours)
    render inertia: 'events/index', props: {
      upcoming: upcoming.as_json(methods: :name),
      past: past.as_json(methods: :name)
    }
  end
end