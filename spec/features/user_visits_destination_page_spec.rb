require 'rails_helper'

RSpec.describe "User visits destination page and" do
  scenario "sees weather information for that zipcode" do
    # As a user
    # When I visit "/"
    visit "/"
    # And I click on a destination
    destination = create(:destination, name: "Denver, CO")
    click_on "Denver, CO"
    # Then I should be on page "/destinations/:id"
    expect(current_path).to eq destination_path(destination)
    # Then I should see the destination's name, zipcode, description, and 10 day weather forecast
    VCR.use_cassette("api/v1/requests/user_visits_destination_page_spec.rb") do
      expect(page).to have_content destination.name
      expect(page).to have_content destination.zipcode
      expect(page).to have_content destination.description
      expect(page).to have_content "10 Day Forecast for Denver, CO"
      # The forecast should include date (weekday, month and day), high and low temps (F), and weather conditionss
      expect(page).to have_content "Monday, September 11"
      expect(page).to have_content "High: 91"
      expect(page).to have_content "Low: 62"
      expect(page).to have_content "Partly cloudy"
    end
    # The weather forecast is specific to the destination whose page I'm on
    destination_2 = create(:destination, name: "Ft. Collins, CO")
    expect(page).to_not have_content destination_2.name
    expect(page).to_not have_content destination_2.zipcode
    expect(page).to_not have_content destination_2.description
    expect(page).to_not have_content "10 Day Forecast for Ft. Collins, CO"
  end
end
