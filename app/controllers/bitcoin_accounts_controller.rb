require 'oauth2'

class BitcoinAccountsController < ApplicationController

  # authorize_resource
  before_action :authenticate_account! #, only: [:transactions, :payment]

  swagger_controller :bitcoin_account, "Bitcoin Account Management"

  swagger_api :show do
    summary "Fetches a single bitcoin account"
    param :path, :id, :integer, :required, "Bitcoin Account ID"
    response :ok, "Success", :BitcoinAccount 
  end

  def show
    bitcoin_account = set_bitcoin_account
    render json: bitcoin_account
  end

  swagger_api :create do
    summary "Create a single Bitcoin Account"
    param :form, :authentication_code, :string, :required, "Authentication code"
    response :ok, "Success"
    response :unprocessable_entity, "Could not create the access token"
    response :forbidden, "Permission denied"
  end

  def create
    if can? :create, BitcoinAccount
      client_id = '694fc2f618facf30b3b41726ee6d0ac04c650669ca3d114cb0bae4223cecade3'
      client_secret = '3e7cfd07d829211ac50dd6486fe677ca76e965f25ad7d68e67e845e0d4a213e7'
      redirect_uri = 'urn:ietf:wg:oauth:2.0:oob'
      code = bitcoin_account_params
      client = OAuth2::Client.new(client_id, client_secret, site: 'https://coinbase.com')
      token_response = client.auth_code.get_token(code, redirect_uri: redirect_uri)
      bitcoin_account = BitcoinAccount.new
      bitcoin_account.access_token = token_response.token
      bitcoin_account.refresh_token = token_response.refresh_token
      bitcoin_account.expires_in = token_response.expires_in
      
      current_account.bitcoin_account = bitcoin_account
      current_account.name = bitcoin_account.name

      bitcoin_account.save
      current_account.save

      if bitcoin_account.persisted? && current_account.persisted?
        render json: { message: "OK" }
      else
        render json: { errors: "Could not create the access token" }, status: 422
      end
    else
      render json: { errors: "Permission denied" }, status: 403
    end
  end

  swagger_api :destroy do
    summary "Delete a single Bitcoin Account"
    param :path, :id, :integer, :required, "Bitcoin Account ID"
    response :forbidden, "Permission denied"
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

  swagger_api :transactions do
    summary "Fetches all transactions of a single bitcoin account"
    param :query, :period, :string, :optional, 'Transactions Period ("day", "week" or "month")'
    response :ok, "Success"
    response :forbidden, "Permission denied"
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

  swagger_api :payment do
    summary "Payment"
    param_list :form, :payment, :string, :required, "Payment Info", [ "to", "amount", "notes"]
    param :query, :force, :string, :optional, 'Optional parameter that, if "true", forces the payment.'
    response :ok, "Success", :Transactions
    response :internal_server_error, "Couldn't send money"
    response :forbidden, "Permission denied"
  end

  # POST /payments
  def payment
    account = current_account
    if account != nil
      p = payment_params
      if params[:force] == "true" || can_make_payment(account, p)
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
        end
      else
        render json: { errors: "You can't make that payment" }
      end
    else
      render json: { errors: "Permission denied" }, status: 403
    end
  end


  def coinbase_callback
    if can? :create, BitcoinAccount
      client_id = '694fc2f618facf30b3b41726ee6d0ac04c650669ca3d114cb0bae4223cecade3'
      client_secret = '3e7cfd07d829211ac50dd6486fe677ca76e965f25ad7d68e67e845e0d4a213e7'
      redirect_uri = 'http://ywallet.co/auth/coinbase'
      code = bitcoin_account_params
      client = OAuth2::Client.new(client_id, client_secret, site: 'https://coinbase.com')
      token_response = client.auth_code.get_token(code, redirect_uri: redirect_uri)
      bitcoin_account = BitcoinAccount.new
      bitcoin_account.access_token = token_response.token
      bitcoin_account.refresh_token = token_response.refresh_token
      bitcoin_account.expires_in = token_response.expires_in
      
      current_account.bitcoin_account = bitcoin_account
      current_account.name = bitcoin_account.name

      bitcoin_account.save
      current_account.save

      if bitcoin_account.persisted?
        redirect_to "http://ywallet.co/www/index.html"
      else
        render json: { errors: "Could not create the access token" }, status: 422
      end
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

    def can_make_payment account, payment
      can = true
      account.rules.each do |r|
        if r.active
          expenses = 0
          if r.period == "day"
            expenses = account.bitcoin_account.day_expenses
          elsif r.period == "week"
            expenses = account.bitcoin_account.week_expenses
          elsif r.period == "month"
            expenses = account.bitcoin_account.month_expenses
          end
          if expenses + payment.amount > r.amount
            can = false
          end
        end
      end
      can
    end

end
