class AddLinkToPages < ActiveRecord::Migration[5.1]
  def change
    add_column :pages, :link_ref, :string
  end
end
