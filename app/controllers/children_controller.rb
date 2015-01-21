class ChildrenController < ApplicationController

  authorize_resource

  # GET /children
  def index
    cur_acc = current_account
    if cur_acc.is_child?
      render json: cur_acc.child
    else
      render json: { errors: "You don't have permission" }, status: 403
    end
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

  # POST /children
  def create
    if can? :create, Child
      name = child_params[:account_attributes][:name]
      if name == nil
        name = "random"

      wallet_id = current_account.bitcoin_account.create_wallet(name)
      if wallet_id
        child = Child.create(child_params.merge(:wallet_id => wallet_id))

        if child.persisted?
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
