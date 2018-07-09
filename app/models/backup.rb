class Backup < ApplicationRecord
  enum coin: [:bitcoin, :dogecoin, :litecoin, :blackcoin, :bitcore, :dashcoin, :primecoin, :peercoin, :other]
  enum status: [:not_code, :on, :off, :test]
end
