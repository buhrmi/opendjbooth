class Identity < ApplicationRecord
  belongs_to :dj, optional: true

  def self.from_omniauth! auth_hash
    Identity.where(provider: auth_hash['provider'], provider_id: auth_hash['uid']).first_or_create!(provider_info: auth_hash['info'])
  end

end