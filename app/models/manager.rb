class Manager < ActiveRecord::Base
	has_one :account
	has_many :children
	accepts_nested_attributes_for :account
end
