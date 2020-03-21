class Weather < ActiveRecord::Base
  include DateHelper
  belongs_to :location

  def self.create_with_location(params)
    location = Location.create(lat: params[:location][:lat],
                               lon: params[:location][:lon],
                               city: params[:location][:city],
                               state: params[:location][:state])
    self.create(id: params[:id],
                date: Date.strptime(params[:date], DATE_FORMAT),
                location_id: location.id,
                temperature: params[:temperature].map{|t| t.to_f }.to_json)
  end

  def as_json
    {
        id: self.id,
        date: from_date(self.date),
        temperature: ActiveSupport::JSON.decode(self.temperature),
        location: self.location.as_json
    }
  end
end
