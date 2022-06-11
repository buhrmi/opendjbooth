class Booth < ApplicationRecord
  has_many :slots
  has_many :events
  has_many :djs, through: :slots
  before_save :fetch_google_place_details

  def broadcast_slots day
    BoothChannel.broadcast_to(self, {slots: slots.on_day(day).as_json(include: :dj)})
  end

  def add_dj!(dj, time)
    slots.create!(dj: dj, start_at: [next_empty_time(time),Time.now].max)
  end

  def next_empty_time preferred_time
    # TODO: also check for a time in between existing slots, instead of just appending to last slot
    if slots.on_day(preferred_time).any?
      slots.on_day(preferred_time).order('start_at desc').first.start_at + 10.minutes
    else
      preferred_time
    end
  end

  def fetch_google_place_details
    return unless google_place_id.present?
    response = PLACES.spot(google_place_id)
    self.name = response.name
    self.latitude = response.lat
    self.longitude = response.lng
  end
end
