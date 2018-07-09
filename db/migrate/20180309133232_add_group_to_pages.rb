class AddGroupToPages < ActiveRecord::Migration[5.1]
  def change
    add_column :pages, :group_id, :integer
  end
end
