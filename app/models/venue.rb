class Venue < ApplicationRecord
  has_many :votes
  has_many :voters, through: :votes
end
