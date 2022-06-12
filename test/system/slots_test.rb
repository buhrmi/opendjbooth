require "application_system_test_case"

class SlotsTest < ApplicationSystemTestCase

  test "a visitor can create a slot for himself if he's close" do
    place = Place.find(1)
    
    visit "/places/1"

    # mock the user's location
    page.execute_script "navigator.geolocation.getCurrentPosition = function(success) { success({coords: {latitude: #{place.latitude}, longitude: #{place.longitude}}}); }"
    
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