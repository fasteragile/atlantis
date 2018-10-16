class Venue < ApplicationRecord
  has_many :votes
  has_many :voters, through: :votes

  validates :name, presence: true

  def karma
    self.votes.sum(:value)
  end
end
