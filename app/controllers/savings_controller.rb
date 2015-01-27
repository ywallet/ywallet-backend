class SavingsController < ApplicationController

  #authorize_resource

  def index
    if current_account.is_child?
      savings = Saving.where(child_id: current_account.child)
      #obtem todas as poupanças da child logada
    else
      savings = nil
    end
    render json: savings
  end

  def show
    saving = Saving.find(params[:id])
    render json: saving
  end

  def create
    saving = Saving.new(saving_params)
    saving.save
    render json: saving
  end

  def update
    saving = Saving.new(saving_params)
    saving.update
    render json: saving
  end

  def destroy
    saving = Saving.find(params[:id])
    saving.destroy
    head :no_content
  end

  private
=begin
    def set_saving
      saving = Saving.find(params[:id])
    end
=end

    def saving_params
      params.require(:saving).permit(:finish_date, :value, :child_id)
    end
end
