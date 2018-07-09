class AddInfo2ToAccount < ActiveRecord::Migration[5.1]
  def change
    add_column :accounts, :info2, :string
  end
end
