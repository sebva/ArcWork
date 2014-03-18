class AddNameRankToUser < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :rank, :integer
  end
end
