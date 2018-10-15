class CreateVotes < ActiveRecord::Migration[5.2]
  def change
    create_table :votes do |t|
      t.integer :value
      t.references :venue
      t.references :voter
      t.timestamps
    end
  end
end
