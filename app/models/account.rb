class Account < ActiveRecord::Base
  include DeviseTokenAuth::Concerns::User
  before_create :skip_confirmation!

  belongs_to :manager
  belongs_to :child

  belongs_to :bitcoin_account # this is actually a 'has_one' relation...

  has_many :rules

  def is_manager?
    manager_id != nil && child_id == nil
  end

  def is_child?
    child_id != nil && manager_id == nil
  end
end
