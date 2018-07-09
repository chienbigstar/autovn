class ChangeTypeColumnAccount2 < ActiveRecord::Migration[5.1]
  def change
    change_column :accounts, :info, :string
  end
end
