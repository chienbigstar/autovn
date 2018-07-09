class CreatePages < ActiveRecord::Migration[5.1]
  def change
    create_table :pages do |t|
      t.string :name
      t.integer :time
      t.string :description
      t.integer :coin
      t.text :content

      t.timestamps
    end
  end
end
