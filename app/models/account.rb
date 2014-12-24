class Account < ActiveRecord::Base
  include DeviseTokenAuth::Concerns::User
  before_create :skip_confirmation!

  after_create {
    #a account está constantemente a ser salva, para atualizar tokens
    #logo after_save estaria sempre a ser chamado
    Wallet.create(balance: 0, account_id: id)
  }

  belongs_to :manager
  belongs_to :child
  has_one :wallet

  def is_manager?
    manager_id != nil && child_id == nil
  end

  def is_child?
    child_id != nil && manager_id == nil
  end
end
