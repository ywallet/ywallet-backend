class BitcoinAccountsController < ApplicationController
#ENV['COINBASE_CLIENT_ID'], ENV['COINBASE_CLIENT_SECRET']
  def show
    bitcoin_account = set_bitcoin_account
    render json: bitcoin_account
  end

  def create
    if can? :create, BitcoinAccount
      code = bitcoin_account_params[:authentication_code]
      client = OAuth2::Client.new(ENV['COINBASE_CLIENT_ID'], ENV['COINBASE_CLIENT_SECRET'], site: 'https://coinbase.com')
      token_response = client.auth_code.get_token(code, redirect_uri: redirect_uri)
      bitcoin_account = BitcoinAccount.new
      bitcoin_account.access_token = token_response.token
      bitcoin_account.refresh_token = token_response.refresh_token
      bitcoin_account.expires_in = token_response.expires_in
      bitcoin_account.account = current_account
      bitcoin_account.save
      render json: bitcoin_account
    else
      render json: { errors: "You can't access this child" }, status: 403
    end
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
      #params.require(:bitcoin_account).permit(:access_token, :refresh_token, :expires_in)
      params.require(:authentication_code)
    end
end
