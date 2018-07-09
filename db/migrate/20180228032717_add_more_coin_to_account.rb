class AddMoreCoinToAccount < ActiveRecord::Migration[5.1]
  def change
    add_column :accounts, :potcoin, :string
    add_column :accounts, :kb3coin, :string
  end
end
