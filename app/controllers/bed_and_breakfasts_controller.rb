class BedAndBreakfastsController < ApplicationController
  def index
    venues = Venue.all
    respond_to do |format|
      format.json {
          return venues.as_json
      }
    end
  end
end
