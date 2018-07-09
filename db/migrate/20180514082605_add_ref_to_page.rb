class AddRefToPage < ActiveRecord::Migration[5.1]
  def change
  	add_column :pages, :ref, :text
  end
end
