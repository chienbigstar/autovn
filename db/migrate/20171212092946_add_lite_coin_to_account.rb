class AddLiteCoinToAccount < ActiveRecord::Migration[5.1]
  def change
    add_column :accounts, :litecoin, :string
    add_column :accounts, :ethereum, :string
    add_column :accounts, :bitcoin_cash, :string
    add_column :accounts, :bitcore, :string
    add_column :accounts, :blackcoin, :string
     add_column :accounts, :dashcoin, :string
      add_column :accounts, :peercoin, :string
       add_column :accounts, :primecoin, :string
  end
end
