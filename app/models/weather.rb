class Weather < ActiveRecord::Base
  has_one :location

  def self.create_with_location(params)
    location = Location.create(params[:location])
    self.create(id: params[:id],
                date: Date.strptime(params[:date], "%Y-%m-%d"),
                location_id: location.id,
                temperature: params[:temperature].to_json)
  end
end
