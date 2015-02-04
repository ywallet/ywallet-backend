class Allowance < ActiveRecord::Base
  belongs_to :child

  validates_inclusion_of :period, :in => ["day", "week", "month", "year"]
end
