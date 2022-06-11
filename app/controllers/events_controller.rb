class EventsController < ApplicationController
  def show
    event = Event.find(params[:id])
    redirect_to booth_path(event.booth, date: event.start_at.strftime('%Y-%m-%d'))
  end
end