class CreateDatas < ActiveRecord::Migration[5.1]
  def change
    create_table :datas do |t|
      t.string :key
      t.text :value

      t.timestamps
    end
  end
end
