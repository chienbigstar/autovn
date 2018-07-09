class User < ApplicationRecord
  has_secure_token
  enum role: [:admin, :editor, :member]
	validates :username, uniqueness: true
	has_many :accounts
end
