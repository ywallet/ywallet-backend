class ChildrenController < ApplicationController

  authorize_resource

  swagger_controller :children, "Children Account Management"


  swagger_api :index do 
    summary "Fetches the information of a single children account"
    response :ok, "Success", :Child
    response :forbidden, "You don't have permission"
  end

  # GET /children
  def index
    cur_acc = current_account
    if cur_acc.is_child?
      render json: cur_acc.child
    else
      render json: { errors: "You don't have permission" }, status: 403
    end
  end

  swagger_api :show do
    summary "Fetches the information of a single children account"
    param :path, :id, :integer, :required, "Children ID"
    response :ok, "Success", :Child
    response :forbidden, "You can't access this child"
  end

  # GET /children/1
  def show
    child = Child.find(params[:id])
    if can? :read, child
      render json: child
    else
      render json: { errors: "You can't access this child" }, status: 403
    end
  end

  swagger_api :create do
    summary "Create a Children Account"
    param :form, :manager_id, :integer, :required, "Manager ID"
    param :form, :account_attributes, :string, :required, "Child object containing params"
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
    response :unprocessable_entity, "Couldn't create a wallet for the child" 
    response :forbidden, "You can't create children"
  end

  # POST /children
  def create
    if can? :create, Child
      name = child_params[:account_attributes][:name]
      if name == nil
        name = "random"
      end

      wallet_id = current_account.bitcoin_account.create_wallet(name)
      if wallet_id
        child = Child.new(child_params.merge(:wallet_id => wallet_id))
        child.account.bitcoin_account = current_account.bitcoin_account

        if child.save
          render json: child, status: 201
        else
          render json: { errors: child.errors.full_messages }.to_json, status: 422
        end
      else
        render json: { errors: "Couldn't create a wallet for the child" }, status: 422
      end
    else
      render json: { errors: "You can't create children" }, status: 403
    end
  end

  swagger_api :update do
    summary "Update information on a Child Account"
    param :path, :id, :integer, :required, "Child ID"
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
    response :forbidden, "You can't access this child"
  end

  # PATCH/PUT /children/1
  def update
    child = Child.find(params[:id])

    if can? :update, child
      account = child.account
      if account.update(child_params[:account_attributes])
        render json: child
      else
        render json: { errors: child.errors.full_messages }.to_json, status: :unprocessable_entity
      end
    else
      render json: { errors: "You can't access this child" }, status: 403
    end
  end

  # DELETE /children/1
=begin
  def destroy
    child = Child.find(params[:id])
    child.destroy
    head :no_content
  end
=end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def child_params
      c_params = params.require(:child).permit(:manager_id, account_attributes:[:name,:nickname,:email,:birthday,:phone,:address,:password,:password_confirmation])
      c_params[:account_attributes][:uid] = c_params[:account_attributes][:email]
      c_params[:account_attributes][:provider] = "email"
      c_params
    end
end
