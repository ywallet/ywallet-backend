class Child < ActiveRecord::Base
	has_one :account
	belongs_to :manager
	accepts_nested_attributes_for :account
end
