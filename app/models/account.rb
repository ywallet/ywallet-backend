class Account < ActiveRecord::Base
  include DeviseTokenAuth::Concerns::User
  before_create :skip_confirmation!

  has_one :wallet
end
