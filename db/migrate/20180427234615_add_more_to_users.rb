class AddMoreToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :ip, :string, default: nil
    add_column :users, :info, :string
    add_column :users, :expired, :date
  end
end
