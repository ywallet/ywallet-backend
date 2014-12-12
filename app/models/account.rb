class Account < ActiveRecord::Base
  include DeviseTokenAuth::Concerns::User
  before_create :skip_confirmation!

  after_save { @wallet = Wallet.new(balance: 0) }

  belongs_to :manager
  belongs_to :child
  has_one :wallet

  def is_manager?
  	@manager_id != nil
  end
end
