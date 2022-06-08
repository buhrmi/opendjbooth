Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, Rails.application.credentials.twitter_api_key, Rails.application.credentials.twitter_api_secret
  # provider :facebook, Rails.application.credentials.facebook_app_id, Rails.application.credentials.facebook_app_secret
  # provider :discord, Rails.application.credentials.discord_client_id, Rails.application.credentials.discord_client_secret, scope: 'email identify'
  # OmniAuth.config.on_failure = ApplicationController.action(:oauth_failure)
end