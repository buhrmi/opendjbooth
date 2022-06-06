class EventChannel < ApplicationCable::Channel
  def subscribed
    stream_for Event.find(params[:id])
  end
end