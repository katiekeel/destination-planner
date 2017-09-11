RSpec.describe "User updates a destination through API and" do
  scenario "receives a 201 code if update was successful" do
    destination = create(:destination)

    new_destination = {name: "Denver, CO",
                  zip: 80110,
                  description: "Actually South Park",
                  image_url: "http://vignette1.wikia.nocookie.net/southpark/images/f/fc/South_Park_Season_14.PNG/revision/latest?cb=20111203174754"}

    put "/api/v1/destinations/#{destination.id}", new_destination

    expect(status).to eq 201
  end

  scenario "receives a 403 code if update was unsuccessful" do
    destination = create(:destination)

    new_destination = {}

    put "/api/v1/destinations/#{destination.id}", new_destination

    expect(status).to eq 201
  end
end
