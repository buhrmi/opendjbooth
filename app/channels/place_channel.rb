class PlaceChannel < ApplicationCable::Channel
  def subscribed
    stream_for Place.find(params[:id])
  end
end