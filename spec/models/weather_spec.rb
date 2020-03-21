require 'rails_helper'

RSpec.describe Weather, type: :model do
  describe '#create' do
    it 'should create a weather entry along with location' do
      weather = nil
      temperature_array = [
          28.5, 27.6, 26.7, 25.9, 25.3, 24.7,
          24.3, 24.0, 27.1, 34.0, 38.6, 41.3,
          43.2, 44.4, 45.0, 45.3, 45.1, 44.2,
          41.9, 38.0, 35.0, 33.0, 31.1, 29.9
      ]
      expect do
        weather = Weather.create_with_location({
                           id: 1,
                           date: "1985-01-01",
                           location: {
                               lat: 35.1442,
                               lon: -111.6664,
                               city: "Flagstaff",
                               state: "Arizona"
                           },
                           temperature: temperature_array
                       })
      end.to change{Weather.count}.by(1)
         .and change{Location.count}.by(1)

      expect(weather.id).to eq(1)
      expect(weather.date.strftime(DateHelper::DATE_FORMAT)).to eq("1985-01-01")
      expect(ActiveSupport::JSON.decode(weather.temperature)).to eq(temperature_array)
    end
  end

  describe '#as_json' do
    it 'should get all the attributes of the model except location_id' do
      temperature_array = [
          28.5, 27.6, 26.7, 25.9, 25.3, 24.7,
          24.3, 24.0, 27.1, 34.0, 38.6, 41.3,
          43.2, 44.4, 45.0, 45.3, 45.1, 44.2,
          41.9, 38.0, 35.0, 33.0, 31.1, 29.9
      ]
      weather = Weather.create_with_location({
                                                 id: 1,
                                                 date: "1985-01-01",
                                                 location: {
                                                     lat: 35.1442,
                                                     lon: -111.6664,
                                                     city: "Flagstaff",
                                                     state: "Arizona"
                                                 },
                                                 temperature: temperature_array
                                             })
      weather_json = weather.as_json
      expect(weather_json).to eq(
                                  {
                                      id: 1,
                                      date: "1985-01-01",
                                      location: {
                                          lat: 35.1442,
                                          lon: -111.6664,
                                          city: "Flagstaff",
                                          state: "Arizona"
                                      },
                                      temperature: temperature_array
                                  }
                              )
    end
  end
end