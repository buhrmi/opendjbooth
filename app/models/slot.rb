class Slot < ApplicationRecord
  belongs_to :event
  belongs_to :dj

  after_commit -> { event.broadcast_slots }

  PUBLIC_OPTIONS = {
    include: {dj: {except: :email, methods: :socials}}
  }
end
