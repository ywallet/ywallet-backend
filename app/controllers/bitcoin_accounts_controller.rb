require 'oauth2'

class BitcoinAccountsController < ApplicationController

  authorize_resource

  def show
    bitcoin_account = set_bitcoin_account
    render json: bitcoin_account
  end

  def create
    if can? :create, BitcoinAccount
      client_id = '694fc2f618facf30b3b41726ee6d0ac04c650669ca3d114cb0bae4223cecade3'
      client_secret = '3e7cfd07d829211ac50dd6486fe677ca76e965f25ad7d68e67e845e0d4a213e7'
      redirect_uri = 'https://ywallet.callback/coinbase/'
      code = bitcoin_account_params
      client = OAuth2::Client.new(client_id, client_secret, site: 'https://coinbase.com')
      token_response = client.auth_code.get_token(code, redirect_uri: redirect_uri)
      bitcoin_account = BitcoinAccount.new
      bitcoin_account.access_token = token_response.token
      bitcoin_account.refresh_token = token_response.refresh_token
      bitcoin_account.expires_in = token_response.expires_in
      bitcoin_account.account = current_account
      bitcoin_account.save
      if bitcoin_account.persisted?
        render json: { message: "OK" }
      else
        render json: { errors: "Could not create the access token" }, status: 422
      end
    else
      render json: { errors: "You can't access this child" }, status: 403
    end
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
      params.require(:authentication_code)
    end
end
