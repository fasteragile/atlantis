class Vote < ApplicationRecord
  belongs_to :voter
  belongs_to :venue

  validates :value, presence: true, inclusion: {:in => [1,-1,0]}

  delegate :name, to: :venue, prefix: true, allow_nil: false
  delegate :first_name, to: :voter, prefix: true, allow_nil: false
  delegate :last_name, to: :voter, prefix: true, allow_nil: false

end
