class CreateBackups < ActiveRecord::Migration[5.1]
  def change
    create_table :backups do |t|
      t.string :name
      t.integer :time
      t.string :description
      t.integer :coin
      t.text :content
      t.integer :status

      t.timestamps
    end
  end
end
