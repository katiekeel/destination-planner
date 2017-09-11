class WeatherService

  attr_reader :zip

  def initialize(zip)
    @zip = zip
    @conn = Faraday.new(url: "http://api.wunderground.com/api/") do |faraday|
      faraday.adapter Faraday.default_adapter
    end
  end

  def get_url(url)
    response = @conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.find_forecast(zipcode)
    new(zipcode).find_forecast_by_zipcode
  end

  def find_forecast_by_zipcode
    get_url("#{ENV["WUNDERGROUND_KEY"]}/forecast10day/q/#{zip}.json")
  end
end
