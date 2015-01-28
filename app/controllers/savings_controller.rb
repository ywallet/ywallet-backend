class SavingsController < ApplicationController

  #authorize_resource

  swagger_controller :savings, "Savings Management"

  swagger_api :index do
    summary "Fetches all savings from a child account"
    response :ok, "Success", :Saving  
  end

  def index
    if current_account.is_child?
      savings = Saving.where(child_id: current_account.child)
      #obtem todas as poupanças da child logada
    else
      savings = nil
    end
    render json: savings
  end

  swagger_api :show do
    summary "Fetches all savings from a child account"
    param :path, :id, :integer, :required, "Child ID"
    response :ok, "Success", :Saving  
  end

  def show
    saving = Saving.find(params[:id])
    render json: saving
  end

  swagger_api :create do
    summary "Create a saving"
    param :form, :saving, :string, :required, "Saving object containing params"
    param :form, :finish_date, :string, :required, "saving[:finish_date]"
    param :form, :value, :string, :required, "rule[:value]"
    param :form, :child_id, :integer, :required, "rule[:child_id]"
    response :ok, "Success", :Saving
  end

  def create
    saving = Saving.new(saving_params)
    saving.save
    render json: saving
  end

  swagger_api :Update do
    summary "Update a saving"
    param :form, :saving, :string, :required, "Saving object containing params"
    param :form, :finish_date, :string, :optional, "saving[:finish_date]"
    param :form, :value, :string, :optional, "rule[:value]"
    param :form, :child_id, :integer, :optional, "rule[:child_id]"
    response :ok, "Success", :Saving
  end

  def update
    saving = Saving.new(saving_params)
    saving.update
    render json: saving
  end

  swagger_api :destroy do
    summary "Delete a saving"
    param :path, :id, :integer, :required, "Child ID"
    response :ok, "Sucess"
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
