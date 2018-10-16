class VotesController < ApplicationController
  def create
    if (vote = Vote.create(vote_params))
      respond_to do |format|
        format.json { render json: vote }
      end
    else
      respond_to do |format|
        format.json { render json: vote.errors, status: :unprocessible_entity }
      end
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
end
