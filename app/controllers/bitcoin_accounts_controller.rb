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
      render json: { errors: "Permission denied" }, status: 403
    end
  end

  def destroy
    bitcoin_account = set_bitcoin_account
    if can? :destroy, bitcoin_account
      bitcoin_account.destroy
      head :no_content
    else
      render json: { errors: "Permission denied" }, status: 403
    end
  end

  # GET /transactions
  def transactions
    account = current_account
    if account != nil
      transactions = nil
      if params[:period] == "week"
        transactions = account.bitcoin_account.week_transactions
      else
        transactions = account.bitcoin_account.transactions
      end
      render json: transactions, each_serializer: TransactionSerializer
    else
      render json: { errors: "Permission denied" }, status: 403
    end
  end

  # POST /payments
  def payment
    account = current_account
    if account != nil
      p = payment_params
      bitcoin_account = account.bitcoin_account
      r = nil
      if account.is_child?
        r = bitcoin_account.send_money(to: p.to, amount: p.amount, notes: p.notes, options: { account_id: account.child.wallet_id })
      else
        r = bitcoin_account.send_money(to: p.to, amount: p.amount, notes: p.notes)
      end
      if r.success?
        render json: r.transaction, serializer: TransactionSerializer
      else
        render json: { errors: "Couldn't send money" }, status: 500
    else
      render json: { errors: "Permission denied" }, status: 403
    end
  end


  private
    def set_bitcoin_account
      bitcoin_account = BitcoinAccount.find_by_account_id(params[:id])
    end

    def bitcoin_account_params
      params.require(:authentication_code)
    end

    def payment_params
      params.require(:payment).permit(:to, :amount, :notes)
    end

end
