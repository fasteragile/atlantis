class Vote < ApplicationRecord
  belongs_to :voter
  belongs_to :venue

  validates :value, presence: true, inclusion: {:in => [1,-1,0]}

end
