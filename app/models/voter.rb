class Voter < ApplicationRecord
  has_many :votes
  has_many :venues, through: :votes
end
