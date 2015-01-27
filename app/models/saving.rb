class Saving < ActiveRecord::Base
  belongs_to :child

  def days_left
  	days_left = (Date.today - finish_date).to_i
  	(days_left/365.25).to_i
  end

  def amount_left
  	balance = child.account.bitcoin_account.balance
  	amount_left = value - balance
  	amount_left
  end
end
