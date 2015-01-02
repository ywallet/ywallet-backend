class Wallet < ActiveRecord::Base
  belongs_to :account
  has_many :rules

  def self.send_money
  	puts "OLAAAAAAAAAAAAAAAAAAAA"
  	#coinbase = Coinbase::Client.new(ENV['COINBASE_API_KEY'], ENV['COINBASE_API_SECRET'])
  	#r = coinbase.send_money '144H17xsQxvvN8vnh2xDM8s3Htu2KA9MBn', 0.002
  	#puts r.success?
  	#r.transaction.status
  	#puts r.transaction.recipient.email
  	puts "OLEEEEEEEEEEEEEEEEE"
  end
end
