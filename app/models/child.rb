class Child < ActiveRecord::Base
	has_one :account
	has_one :wallet, through: :account
	belongs_to :manager
end
