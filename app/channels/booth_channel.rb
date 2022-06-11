class BoothChannel < ApplicationCable::Channel
  def subscribed
    stream_for Booth.find(params[:id])
  end
end