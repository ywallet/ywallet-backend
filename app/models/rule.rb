class Rule < ActiveRecord::Base
  belongs_to :account

  validates_inclusion_of :period, :in => ["day", "week", "month", "year"]
end
