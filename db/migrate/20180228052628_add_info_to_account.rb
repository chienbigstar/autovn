class AddInfoToAccount < ActiveRecord::Migration[5.1]
  def change
    add_column :accounts, :info, :text
  end
end
