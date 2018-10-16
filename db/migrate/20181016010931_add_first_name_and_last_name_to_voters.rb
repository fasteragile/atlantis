class AddFirstNameAndLastNameToVoters < ActiveRecord::Migration[5.2]
  def change
    add_column :voters, :first_name, :string
    add_column :voters, :last_name, :string
    remove_column :voters, :name, :string
  end
end
