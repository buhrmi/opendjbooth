require "application_system_test_case"

class SlotsTest < ApplicationSystemTestCase

  test "a visitor can create a slot for himself if he's close" do
    event = Event.find(1)
    
    visit "/events/1"

    # mock the user's location
    page.execute_script "navigator.geolocation.getCurrentPosition = function(success) { success({coords: {latitude: #{event.latitude}, longitude: #{event.longitude}}}); }"
    
    # make sure a slot record is  created
    assert_difference('Slot.count', 1) do
      fill_in "name", with: "skrillex"
      click_button "add"
      assert_text "Your time is "
    end

    # mail = ActionMailer::Base.deliveries.last
    # pw = mail.body.match(/Passwort:(.*)/)[1].strip
  end

end