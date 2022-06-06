InertiaRails.configure do |config|
  config.version = lambda do 
    ENV['HEROKU_RELEASE_VERSION']
  end
end
