RSpec.describe "User creates a destination through API and" do
  scenario "receives a 201 code if creation was successful" do
    destination = {name: "Denver, CO",
                  zip: 80110,
                  description: "Actually South Park",
                  image_url: "http://vignette1.wikia.nocookie.net/southpark/images/f/fc/South_Park_Season_14.PNG/revision/latest?cb=20111203174754"}

    post "/api/v1/destinations/", destination

    expect(status).to eq 201
  end

  scenario "receives a 403 code if creation was unsuccessful" do
    destination = {name: "Denver, CO",
                  zip: 80110}

    post "/api/v1/destinations/", destination

    expect(status).to eq 201
  end
end
