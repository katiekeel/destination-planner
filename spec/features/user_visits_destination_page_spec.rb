require 'rails_helper'

RSpec.describe "User visits destination page and" do
  scenario "sees weather information for that zipcode" do
    # As a user
    # When I visit "/"
    visit "/"
    # And I click on a destination
    destination = create(:destination, name: "Denver, CO")
    visit destination_path(destination)
    # Then I should be on page "/destinations/:id"
    expect(current_path).to eq destination_path(destination)
    # Then I should see the destination's name, zipcode, description, and 10 day weather forecast
    VCR.use_cassette("api/v1/requests/user_visits_destination_page_spec.rb") do
      expect(page).to have_content destination.name
      expect(page).to have_content destination.zip
      expect(page).to have_content destination.description
      expect(page).to have_content "Forecast for Denver, CO"

      response = WeatherService.find_forecast("80110")
      stats = response[:forecast][:simpleforecast][:forecastday][0]

      # The forecast should include date (weekday, month and day), high and low temps (F), and weather conditionss
      expect(page).to have_content stats[:high][:fahrenheit]
      expect(page).to have_content stats[:low][:fahrenheit]
      expect(page).to have_content stats[:conditions]
    end
    # The weather forecast is specific to the destination whose page I'm on
    destination_2 = create(:destination, name: "Ft. Collins, CO", description: "Plain ol' plains", zip: 12345)
    expect(page).to_not have_content destination_2.name
    expect(page).to_not have_content destination_2.zip
    expect(page).to_not have_content destination_2.description
    expect(page).to_not have_content "Forecast for Ft. Collins, CO"
  end
end
