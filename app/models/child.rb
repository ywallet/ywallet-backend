class Child < ActiveRecord::Base
	has_one :account
	belongs_to :manager
  has_many :savings
  
	accepts_nested_attributes_for :account
end
