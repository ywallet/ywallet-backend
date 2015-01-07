class BitcoinAccountsController < ApplicationController

  def show
    bitcoin_account = set_bitcoin_account
    render json: bitcoin_account
  end

  def create
    bitcoin_account = BitcoinAccount.new(bitcoin_account_params.merge(account_id: current_account.id))
    bitcoin_account.save
    render json: bitcoin_account
  end

  def update
    bitcoin_account = set_bitcoin_account
    #TODO
    #bitcoin_account.update(bitcoin_account_params)
    render json: bitcoin_account
  end

  def destroy
    bitcoin_account = set_bitcoin_account
    bitcoin_account.destroy
    head :no_content
  end

  private
    def set_bitcoin_account
      bitcoin_account = BitcoinAccount.find_by_account_id(params[:id])
    end

    def bitcoin_account_params
      params.require(:bitcoin_account).permit(:access_token, :refresh_token, :expires_in)
    end
end
