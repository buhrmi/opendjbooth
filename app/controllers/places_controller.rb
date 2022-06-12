class PlacesController < ApplicationController
  def show
    place = Place.find(params[:id])
    if params[:date]
      date = Time.parse(params[:date])
    else
      date = Time.now.beginning_of_day
    end
      
    slots = place.slots.on_day(date)
    
    @description = date.strftime('%A, %B %e, %Y')
    
    render inertia: 'places/show', props: {
      place: place,
      date: date,
      slots: slots.as_json(Slot::PUBLIC_OPTIONS)
    }
  end

  def index
    render inertia: 'places/index', props: {
      places: Place.all
    }
  end

end