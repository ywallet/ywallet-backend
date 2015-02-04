class SavingsController < ApplicationController

  authorize_resource

  swagger_controller :savings, "Savings Management"

  swagger_api :index do
    summary "Fetches all savings from a child account"
    response :ok, "Success", :Saving  
  end

  def index
    if can? :read, Saving
      if current_account.is_child?
        savings = Saving.where(child_id: current_account.child)
        #obtem todas as poupanças da child logada
      else
        savings = nil
      end
      render json: savings
    else
      render json: { errors: "You can't access savings" }, status: 403
    end
  end

  swagger_api :show do
    summary "Fetches all savings from a child account"
    param :path, :id, :integer, :required, "Child ID"
    response :ok, "Success", :Saving  
  end

  def show
    saving = Saving.find(params[:id])
    if can? :read, saving
      render json: saving
    else
      render json: { errors: "You can't access this saving" }, status: 403
    end
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
    if can? :create, Saving
      saving = Saving.create(saving_params)
      if saving.persisted?
        render json: saving
      else
        render json: { errors: "Error creating saving" }, status: 422
      end
    else
      render json: { errors: "You can't create savings" }, status: 403
    end
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
    saving = Saving.find(params[:id])
    if can? :update, saving
      saving.update(saving_params)
      if saving.persisted?
        render json: saving
      else
        render json: { errors: "Error updating saving" }, status: 422
      end
    else
      render json: { errors: "You can't access this saving" }, status: 403
    end
  end

  swagger_api :destroy do
    summary "Delete a saving"
    param :path, :id, :integer, :required, "Child ID"
    response :ok, "Sucess"
  end

  def destroy
    saving = Saving.find(params[:id])
    if can? :destroy, saving
      saving.destroy
      head :no_content
    else
      render json: { errors: "You can't destroy this saving" }, status: 403
    end
  end

  private

    def saving_params
      params.require(:saving).permit(:finish_date, :value, :child_id)
    end
end
