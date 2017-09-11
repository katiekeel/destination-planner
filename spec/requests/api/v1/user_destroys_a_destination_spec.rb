RSpec.describe "User destroys a destination through API and" do
  scenario "receives a 201 code if destroy was successful" do
    destination = create(:destination)

    delete "/api/v1/destinations/#{destination.id}"

    expect(status).to eq 201
  end
end
