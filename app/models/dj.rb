class Dj < ApplicationRecord
  has_many :slots
  has_many :events, through: :slots
  has_many :identities

  validates :name, presence: true, length: { maximum: 255, minimum: 3 }

  def socials
    result = {}
    identities.each do |i|
      result[i.provider] = i.provider_info['username'] || i.provider_info['nickname']
    end
    result
  end

  def twitter_name
    socials['twitter']
  end

end
