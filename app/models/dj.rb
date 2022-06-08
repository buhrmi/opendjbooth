class Dj < ApplicationRecord
  has_many :slots
  has_many :events, through: :slots
  
  validates :name, presence: true, length: { maximum: 255, minimum: 3 }
end
