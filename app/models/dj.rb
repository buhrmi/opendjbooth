class Dj < ApplicationRecord
  has_many :slots
  has_many :events, through: :slots
  has_many :identities

  validates :name, presence: true, length: { maximum: 255, minimum: 3 }

  def socials
    result = {}
    identities.each do |i|
      result[i.provider] = {
        username: i.provider_info['username'] || i.provider_info['nickname'],
        name: i.provider_info['name']
      }
    end
    result
  end

end
