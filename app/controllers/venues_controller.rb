class VenuesController < ApplicationController
  def index
    venues = Venue.includes(:votes).all

    respond_to do |format|
      format.json {
        render json: venues.as_json(only: [:id, :name], methods: :karma)
      }
    end
  end
end
