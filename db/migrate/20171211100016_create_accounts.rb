class CreateAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :accounts do |t|
      t.integer :user_id
      t.integer :ip
      t.string :email
      t.string :username
      t.string :api_key
      t.string :password
      t.string :bitcoin
      t.string :dogecoin
      t.text :list

      t.timestamps
    end
  end
end
