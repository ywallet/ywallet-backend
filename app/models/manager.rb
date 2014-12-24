class Manager < ActiveRecord::Base
	has_one :account
	has_one :wallet, through: :account
	has_many :children
	accepts_nested_attributes_for :account

	#devolve uma hash contendo os ids dos filhos como chaves
	#e as respetivas carteiras como chave
	def childrens_wallets

		childrens_wallets = Hash.new
		child_ids.each do |child_id|
			childrens_wallets[child_id] = Child.find(child_id).wallet.id
		end
		childrens_wallets
	end

	#ids das wallets de que é manager
	def wallet_ids
		
		wallet_ids = Array.new
		child_ids.each do |child_id|
			wallet_ids.push(Child.find(child_id).wallet.id)
		end
		wallet_ids
	end
end
