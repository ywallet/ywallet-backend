class WalletsController < ApplicationController

  authorize_resource

=begin
  def index
    render json: Wallet.all
  end
=end

  def show
    wallet = Wallet.find(params[:id])
    if can? :read, wallet
      Wallet.send_money
      render json: wallet
    else
      render json: { errors: "You can't access this wallet" }, status: 403
    end
  end

=begin
  def create
    wallet = Wallet.create(wallet_params)

    if wallet.persisted?
      render json: wallet, status: 201
    else
      render json: { errors: wallet.errors.full_messages }.to_json, status: 422
    end
  end
=end

=begin
  def update
    wallet = Wallet.find(params[:id])

    if can? :update, wallet
      if wallet.update(wallet_params)
        render json: wallet
      else
        render json: { errors: wallet.errors.full_messages }.to_json, status: :unprocessable_entity
      end
    else
      render json: { errors: "You can't access this wallet" }, status: 403
    end
  end
=end

=begin
  def destroy
    wallet = Wallet.find(params[:id])
    wallet.destroy
    head :no_content
  end
=end

  private
    def wallet_params
      params.require(:wallet).permit(:balance, :account_id)
    end
end
