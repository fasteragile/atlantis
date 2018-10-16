class Voter < ApplicationRecord
  has_many :votes
  has_many :venues, through: :votes
  validates :first_name, presence: true
  validates :last_name, presence: true
end
