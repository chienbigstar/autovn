class Page < ApplicationRecord
  belongs_to :group, optional: true

  enum coin: [:bitcoin, :dogecoin, :litecoin, :blackcoin,
              :bitcore, :dashcoin, :primecoin, :peercoin, :ethereum, :bitcoincash, :potcoin, :kb3coin,  :other]
  enum status: [:on, :off]
  enum chuoi: [:yes, :no]
end
