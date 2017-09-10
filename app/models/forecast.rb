class Forecast

  attr_reader :raw_forecast,
              :days


  def initialize(raw_forecast)
    @raw_forecast = raw_forecast
    @days = []
    create_forecast_days
  end

  def self.find_by_id(destination_id)
    zip = Destination.find(destination_id).zip
    new(WeatherService.find_forecast(zip))
  end

  def create_forecast_days
    raw_forecast[:forecast][:simpleforecast][:forecastday]
      .each_with_index do |day, index|
        @days << {date: parse_date(index),
                  high: raw_forecast[:forecast][:simpleforecast][:forecastday][index][:high][:fahrenheit],
                  low: raw_forecast[:forecast][:simpleforecast][:forecastday][index][:low][:fahrenheit],
                  conditions: raw_forecast[:forecast][:simpleforecast][:forecastday][index][:conditions]}
    end
  end

  def parse_date(index)
    date = ""
    date += raw_forecast[:forecast][:simpleforecast][:forecastday][index][:date][:weekday]
    date += ", "
    date += raw_forecast[:forecast][:simpleforecast][:forecastday][index][:date][:pretty].split("on ")[-1]
    date
  end

end
