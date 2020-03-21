class Location < ActiveRecord::Base
  def as_json
    {
        lat: self.lat,
        lon: self.lon,
        city: self.city,
        state: self.state,
    }
  end
end
