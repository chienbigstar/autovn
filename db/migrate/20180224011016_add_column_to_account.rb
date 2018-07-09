class AddColumnToAccount < ActiveRecord::Migration[5.1]
  def change
    rename_column :accounts, :api_key, :cheapcaptcha_api_key
    add_column :accounts, :anticaptcha_api_key, :string
    add_column :accounts, :_2captcha_api_key, :string
  end
end
