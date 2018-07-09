class AddGroupToAccount < ActiveRecord::Migration[5.1]
  def change
    add_column :accounts, :group_id, :integer
  end
end
