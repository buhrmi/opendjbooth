class Identity < ApplicationRecord
  belongs_to :user

  def self.from_omniauth! auth_hash
    Identity.find_or_create_by(provider: auth_hash['provider'], provider_id: auth_hash['uid']).tap do |identity|
      identity.provider_info = auth_hash['info']
      identity.save
    end
  end

end