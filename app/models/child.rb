class Child < ActiveRecord::Base
	has_one :account
	belongs_to :manager
  
  has_many :savings

  has_many :allowances
  
	accepts_nested_attributes_for :account
end
