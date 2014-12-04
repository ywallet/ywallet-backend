class WalletsController < ApplicationController
  before_action :set_wallet, only: [:show, :edit, :update, :destroy]
  # Add this line when authentication is in place
  #before_action :authenticate_user!

  def index
    @wallets = Wallet.all
    respond_with(@wallets)
  end

  def show
    respond_with(@wallet)
  end

  def new
    @wallet = Wallet.new
    respond_with(@wallet)
  end

  def edit
  end

  def create
    @wallet = Wallet.new(wallet_params)
    @wallet.save
    respond_with(@wallet)
  end

  def update
    @wallet.update(wallet_params)
    respond_with(@wallet)
  end

  def destroy
    @wallet.destroy
    respond_with(@wallet)
  end

  private
    def set_wallet
      @wallet = Wallet.find(params[:id])
    end

    def wallet_params
      params.require(:wallet).permit(:balance, :account_id)
    end
end
