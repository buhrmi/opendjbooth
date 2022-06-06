class Event < ApplicationRecord
  has_many :slots
  has_many :djs, through: :slots

  before_save :fetch_google_place_details


  def fetch_google_place_details
    return unless google_place_id.present?
    response = PLACES.spot(google_place_id)
    self.name = response.name
    self.latitude = response.lat
    self.longitude = response.lng
  end
end
