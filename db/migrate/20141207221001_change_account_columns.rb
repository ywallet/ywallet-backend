class ChangeAccountColumns < ActiveRecord::Migration
  def self.up
    change_table :accounts do |t|
      t.change :provider, :string, :null => true
      t.change :uid, :string, :null => true
      t.change :sign_in_count, :integer, :null => true
      t.change :encrypted_password, :string, :null => true
    end
  end
  def self.down
    change_table :accounts do |t|
      t.change :provider, :string, :null => false
      t.change :uid, :string, :null => false
      t.change :sign_in_count, :integer, :null => false
      t.change :encrypted_password, :string, :null => false
    end
  end
end
