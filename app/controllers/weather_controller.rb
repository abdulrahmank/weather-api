class WeatherController < ApplicationController
  include DateHelper

  def delete
    weathers = Weather.all
    start_date = to_date(params[:start])
    end_date = to_date(params[:end])

    weathers = weathers.where(date: start_date..end_date) if start_date && end_date
    weathers = weathers.joins(:location).where(locations: {lat: params[:lat], lon: params[:lon]}) if params[:lat] && params[:lon]

    weathers.destroy_all
    render json: {} ,status: :ok
  rescue StandardError => e
    render json: {
        error: 'Something went wrong'
    }
  end

  def create
    render json: {}, status: :bad_request and return if Weather.find_by(id: params[:id])

    Weather.create_with_location(params)

    render json: {}, status: :created
  end

  def index
    weathers = Weather.all.order(id: :asc)

    weathers = weathers.where(date: params[:date]) if params[:date]
    weathers = weathers.joins(:location).where(locations: {lat: params[:lat], lon: params[:lon]}) if params[:lat] && params[:lon]

    render json: weathers.as_json, status: :ok
  end
end
