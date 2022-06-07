require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  teardown do 
    next if passed?
    logs = page.driver.browser.logs.get(:browser)
    if logs.present?
      message = logs.map(&:message).reject { |m| m.include? 'unknown prop' }.reject { |m| m.include? 'unexpected slot' }.join("\n")
      puts message
    end
  end
  
  driven_by :selenium, using: :headless_chrome, screen_size: [1400, 1400]
end
