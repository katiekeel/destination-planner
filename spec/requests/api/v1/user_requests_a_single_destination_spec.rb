RSpec.describe "User requests a single destination through API and" do
  scenario "receives the destination with its details" do
    destinations = create_list(:destination, 4)

    get "/api/v1/destinations/#{destinations.first.id}"

    result = JSON.parse(response.body)
    results = []
    results << result

    expect(result.class).to eq Hash
    expect(results.count).to eq 1
    expect(results.first["name"]).to eq(destinations.first.name)
    expect(results.last["name"]).to eq(destinations.first.name)
    expect(results.first["zip"]).to eq(destinations.first.zip)
    expect(results.last["zip"]).to eq(destinations.first.zip)
    expect(results.first["description"]).to eq(destinations.first.description)
    expect(results.last["description"]).to eq(destinations.first.description)
    expect(results.first["image_url"]).to eq(destinations.first.image_url)
    expect(results.last["image_url"]).to eq(destinations.first.image_url)
  end
end
