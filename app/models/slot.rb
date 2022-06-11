class Slot < ApplicationRecord
  belongs_to :booth
  belongs_to :dj

  after_commit -> { booth.broadcast_slots(start_at) }

  scope :on_day, -> (day) { where('start_at between ? and ?', day.beginning_of_day, day.end_of_day) }

  PUBLIC_OPTIONS = {
    include: {dj: {except: :email, methods: :twitter_name}}
  }
end
