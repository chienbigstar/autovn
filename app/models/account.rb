class Account < ApplicationRecord
	validates :ip, uniqueness: true, presence: true
	belongs_to :user
	belongs_to :group, optional: true

	enum status: [:on, :off, :die]
end
