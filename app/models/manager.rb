class Manager < ActiveRecord::Base
	has_one :account
	has_one :wallet, through: :account
	has_many :children
end
