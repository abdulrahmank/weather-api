require 'rails_helper'

RSpec.describe WeatherController, type: :controller do
  before do
    @temperature_array = [
        28.5, 27.6, 26.7, 25.9, 25.3, 24.7,
        24.3, 24.0, 27.1, 34.0, 38.6, 41.3,
        43.2, 44.4, 45.0, 45.3, 45.1, 44.2,
        41.9, 38.0, 35.0, 33.0, 31.1, 29.9
    ]
  end
  describe '#delete' do
    before do
      weather1 = Weather.create_with_location({
                                                  id: 1,
                                                  date: "1985-01-01",
                                                  location: {
                                                      lat: 35.1442,
                                                      lon: -111.6664,
                                                      city: "Flagstaff",
                                                      state: "Arizona"
                                                  },
                                                  temperature: @temperature_array
                                              })
      weather2 = Weather.create_with_location({
                                                  id: 2,
                                                  date: "1985-01-03",
                                                  location: {
                                                      lat: 35.1442,
                                                      lon: -111.6664,
                                                      city: "Flagstaff",
                                                      state: "Arizona"
                                                  },
                                                  temperature: @temperature_array
                                              })
      weather3 = Weather.create_with_location({
                                                  id: 3,
                                                  date: "1985-01-01",
                                                  location: {
                                                      lat: 24.7136,
                                                      lon: 46.6753,
                                                      city: "Riyadh",
                                                      state: "Riyadh"
                                                  },
                                                  temperature: @temperature_array
                                              })
    end

    context 'when start, end, lat and lon params not present' do
      it 'should delete all the weather entries' do
        delete :delete

        expect(response.status).to eq(200)
        expect(Weather.count).to eq(0)
      end
    end

    context 'when start, end params are present' do
      it 'should delete only the weather entries for the given start and end_date' do

        delete :delete, start: "1985-01-01", end: "1985-01-02"

        expect(response.status).to eq(200)
        expect(Weather.where(date: Date.strptime("1985-01-01", DateHelper::DATE_FORMAT)..Date.strptime("1985-01-02", DateHelper::DATE_FORMAT)).count).to eq(0)
      end
    end

    context 'when lat and lon params are present' do
      it 'should delete only the weather entries for the given lat and lon' do

        delete :delete, lat: 24.7136, lon: 24.7136

        expect(response.status).to eq(200)
        expect(Weather.joins(:location).where(locations: {lat: 24.7136, lon: 24.7136}).count).to eq(0)
      end
    end

  end

  describe '#create' do
    context 'when weather id not present' do
      it 'should successfully create weather entry' do
        post :create, {
            id: 1,
            date: "1985-01-01",
            location: {
                lat: 35.1442,
                lon: -111.6664,
                city: "Flagstaff",
                state: "Arizona"
            },
            temperature: @temperature_array
        }

        expect(response.status).to eq(201)
        expect(Weather.find(1)).not_to be_nil
      end
    end

    context 'when weather id already present' do
      it 'should return bad request' do
        Weather.create_with_location({
                                         id: 1,
                                         date: "1985-01-01",
                                         location: {
                                             lat: 35.1442,
                                             lon: -111.6664,
                                             city: "Flagstaff",
                                             state: "Arizona"
                                         },
                                         temperature: @temperature_array
                                     })

        post :create, {
            id: 1,
            date: "1985-01-01",
            location: {
                lat: 35.1442,
                lon: -111.6664,
                city: "Flagstaff",
                state: "Arizona"
            },
            temperature: @temperature_array
        }

        expect(response.status).to eq(400)
      end
    end
  end
end
