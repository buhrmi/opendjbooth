class Event < ApplicationRecord
  has_many :slots, through: :event
  has_many :djs, through: :slots

  belongs_to :place

  def name
    attributes[:name] || place.name
  end
end
