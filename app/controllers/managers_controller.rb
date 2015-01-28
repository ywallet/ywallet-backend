class ManagersController < ApplicationController

  authorize_resource

  swagger_controller :managers, "Managers Account Management"

  swagger_api :index do
    summary "Fetches the information of a single manager account"
    response :ok, "Success", :Manager
    response :forbidden, "You don't have permission"
  end

  # GET /managers
  def index
    cur_acc = current_account
    if cur_acc.is_manager?
      render json: cur_acc.manager
    else
      render json: { errors: "You don't have permission" }, status: 403
    end
  end

  swagger_api :show do
    summary "Fetches the information of a single manager account"
    param :path, :id, :integer, :required, "Manager ID"
    response :ok, "Success", :Manager
    response :forbidden, "You can't access this manager"
  end

  # GET /managers/1
  def show
    manager = Manager.find(params[:id])
    if can? :read, manager
      render json: manager
    else
      render json: { errors: "You can't access this manager" }, status: 403
    end
  end

  swagger_api :create do
    summary "Create a manager account"
    param :form, :account_attributes, :string, :required, "Manager object containing params"
    param :form, :name, :string, :optional, "account_attributes[:name]"
    param :form, :nickname, :string, :optional, "account_attributes[:nickname]"
    param :form, :email, :string, :required, "account_attributes[:email]"
    param :form, :birthday, :string, :optional, "account_attributes[:birthday]"
    param :form, :phone, :string, :optional, "account_attributes[:phone]"
    param :form, :address, :string, :optional, "account_attributes[:address]"
    param :form, :password, :string, :required, "account_attributes[:password]"
    param :form, :password_confirmation, :string, :required, "account_attributes[:password_confirmation]"
    response :created, "Created", :Child
    response :unprocessable_entity, "Unprocessable Entity"
  end

  # POST /managers
  def create
    manager = Manager.create(manager_params)

    if manager.persisted?
      render json: manager, status: 201
    else
      render json: { errors: manager.errors.full_messages }.to_json, status: 422
    end
  end

  swagger_api :update do
    summary "Update information on a Manager Account"
    param :path, :id, :integer, :required, "Manager ID"
    param :form, :account_attributes, :string, :required, "Child object containing params"
    param :form, :name, :string, :optional, "account_attributes[:name]"
    param :form, :nickname, :string, :optional, "account_attributes[:nickname]"
    param :form, :email, :string, :optional, "account_attributes[:email]"
    param :form, :birthday, :string, :optional, "account_attributes[:birthday]"
    param :form, :phone, :string, :optional, "account_attributes[:phone]"
    param :form, :address, :string, :optional, "account_attributes[:address]"
    param :form, :password, :string, :optional, "account_attributes[:password]"
    param :form, :password_confirmation, :string, :optional, "account_attributes[:password_confirmation]"
    response :ok, "Success", :Child
    response :unprocessable_entity, "Unprocessable Entity"
    response :forbidden, "You can't access this manager"
  end

  # PATCH/PUT /managers/1
  def update
    manager = Manager.find(params[:id])

    if can? :update, manager
      account = manager.account
      if account.update(manager_params[:account_attributes])
        render json: manager
      else
        render json: { errors: manager.errors.full_messages }.to_json, status: :unprocessable_entity
      end
    else
      render json: { errors: "You can't access this manager" }, status: 403
    end
  end

  # DELETE /managers/1
=begin
  def destroy
    manager = Manager.find(params[:id])
    manager.destroy
    head :no_content
  end
=end

  private
    def manager_params
      m_params = params.require(:manager).permit(account_attributes:[:name,:nickname,:email,:birthday,:phone,:address,:password,:password_confirmation])
      m_params[:account_attributes][:uid] = m_params[:account_attributes][:email]
      m_params[:account_attributes][:provider] = "email"
      m_params
    end
end