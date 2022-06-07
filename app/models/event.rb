class Event < ApplicationRecord
  has_many :slots
  has_many :djs, through: :slots

  before_save :fetch_google_place_details

  def next_empty_time
    if slots.any?
      slots.order('start_at desc').first.start_at + 45.minutes
    else
      start_at
    end
  end

  def add_dj!(dj)
    # TODO: reuse a slot where DJ is nil
    slots.create!(dj: dj, start_at: next_empty_time)
  end

  def fetch_google_place_details
    return unless google_place_id.present?
    response = PLACES.spot(google_place_id)
    self.name = response.name
    self.latitude = response.lat
    self.longitude = response.lng
  end

  def broadcast_slots
    EventChannel.broadcast_to(self, {slots: slots.as_json(include: :dj)})
  end
end
