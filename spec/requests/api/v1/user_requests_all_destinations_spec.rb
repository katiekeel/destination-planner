require 'rails_helper'

RSpec.describe "User requests all destinations through API and" do
  scenario "receives list of all destinations with their details" do
    destinations = create_list(:destination, 4)

    get '/api/v1/destinations'

    results = JSON.parse(response.body)

    expect(results.count).to eq 4
    expect(results.first["name"]).to eq(destinations.first.name)
    expect(results.last["name"]).to eq(destinations.last.name)
    expect(results.first["zip"]).to eq(destinations.first.zip)
    expect(results.last["zip"]).to eq(destinations.last.zip)
    expect(results.first["description"]).to eq(destinations.first.description)
    expect(results.last["description"]).to eq(destinations.last.description)
    expect(results.first["image_url"]).to eq(destinations.first.image_url)
    expect(results.last["image_url"]).to eq(destinations.last.image_url)
  end
end
