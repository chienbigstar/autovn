class ChangeTypeColumnAccount < ActiveRecord::Migration[5.1]
  def change
    change_column :accounts, :ip, :string
  end
end
