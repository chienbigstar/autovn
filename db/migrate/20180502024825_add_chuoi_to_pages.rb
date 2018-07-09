class AddChuoiToPages < ActiveRecord::Migration[5.1]
  def change
    add_column :pages, :chuoi, :integer
  end
end
