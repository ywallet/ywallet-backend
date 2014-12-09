class Child < ActiveRecord::Base
	has_one :account
	has_one :wallet, through: :account
	belongs_to :manager
	accepts_nested_attributes_for :account
end
