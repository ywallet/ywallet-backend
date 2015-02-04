class AllowancesController < ApplicationController

  authorize_resource

  def index
    if can? :read, Allowance
      allowances = nil
      if current_account.is_child?
        allowances = Allowance.where(child_id: current_account.child_id
        #obtem todas as semanadas da child logada
      end
      render json: allowances
    else
      render json: { errors: "You can't access allowances" }, status: 403
    end
  end

  def show
    allowance = Allowance.find(params[:id])
    if can? :read, allowance
      render json: allowance
    else
      render json: { errors: "You can't access this allowance" }, status: 403
    end
  end

  def create
    if can? :create, Allowance
      allowance = Allowance.create(allowance_params)
      if allowance.persisted?
        render json: allowance
      else
        render json: { errors: allowance.errors.full_messages }.to_json, status: 422
      end
    else
      render json: { errors: "You can't create allowances" }, status: 403
    end
  end

  def update
    allowance = Allowance.find(params[:id])
    if can? :update, allowance
      allowance.update(allowance_params)
      if allowance.persisted?
        render json: allowance
      else
        render json: { errors: allowance.errors.full_messages }.to_json, status: 422
      end
    else
      render json: { errors: "You can't access this allowance" }, status: 403
    end
  end

  def destroy
    allowance = Allowance.find(params[:id])
    if can? :destroy, allowance
      allowance.destroy
      head :no_content
    else
      render json: { errors: "You can't destroy this allowance" }, status: 403
    end
  end

  private
    def allowance_params
      params.require(:allowance).permit(:amount, :period, :child_id)
    end
end
