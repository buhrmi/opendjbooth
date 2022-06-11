class Event < ApplicationRecord
  has_many :slots, through: :event
  has_many :djs, through: :slots

  belongs_to :booth
end
