class Slot < ApplicationRecord
  belongs_to :event
  belongs_to :dj

  after_commit -> { event.broadcast_slots }

end
