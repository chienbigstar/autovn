class RenameTableConfigToStandard < ActiveRecord::Migration[5.1]
  def change
    rename_table :configs, :standards
  end
end
