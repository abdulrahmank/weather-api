require 'rails_helper'

RSpec.describe Location, type: :model do
  describe '#create' do
    it 'should create location with given params' do
      expect do
        Location.create({
                            lat: 35.1442,
                            lon: -111.6664,
                            city: "Flagstaff",
                            state: "Arizona"
                        })
      end.to change { Location.count }.by(1)
    end
  end

  describe '#as_json' do
    it 'should return all the attributes except id' do
      location = Location.create({
                          lat: 35.1442,
                          lon: -111.6664,
                          city: "Flagstaff",
                          state: "Arizona"
                      })
      expect(location.as_json).to eq(lat: 35.1442,
                                     lon: -111.6664,
                                     city: "Flagstaff",
                                     state: "Arizona")
    end
  end
end
