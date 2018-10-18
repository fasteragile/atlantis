class VotesController < ApplicationController
  rescue_from Exception, with: :unprocessable_entity
  rescue_from ActionController::ParameterMissing, with: :unprocessable_entity

  def create
    if (@vote = Vote.create(vote_params))
      respond_to do |format|
        format.json {
          render json: @vote.as_json(only: [:id, :value],
                                     methods: [:voter_first_name,
                                               :voter_last_name,
                                               :venue_name])
        }
      end
    else
      unprocessable_entity
    end
  end

  def venue
    @venue ||= Venue.find_or_create_by(name: ballot_params[:name])
  end

  def voter
    @voter ||= Voter.find_or_create_by(ballot_params[:voter])
  end

  def vote_params
    {
      value: ballot_params[:vote],
      voter: voter,
      venue: venue
    }
  end

  def ballot_params
    params.require(:name)
    params.require(:vote)
    params.require(:voter).permit([:first_name, :last_name])

    params.permit(:name, :vote, voter: [:first_name, :last_name])
  end

  # TODO: This is awful. Decide how we want to return errors.
  # A 422 is nice and all, but tell them why they got one. ie. which field is
  # wrong? 
  def unprocessable_entity
    respond_to do |format|
      format.json {
        render json: "You must send me: " \
                      "'{name: <string>, vote: [-1,0,1]," \
                      " voter: {first_name:<string>(optional), " \
                      " last_name:<string>(optional)}}'",
        status: :unprocessable_entity
      }
    end
  end
end
