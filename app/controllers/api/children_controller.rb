module API  
  class ChildrenController < ApplicationController
    # Add this line when authentication is in place
    #before_action :authenticate_account!

    # GET /children
    def index
      render json: Child.all
    end

    # GET /children/1
    def show
      render json: Child.find(params[:id])
    end

    # POST /children
    def create
      child = Child.create(child_params)

      if child.persisted?
        render json: child, status: 201
      else
        render json: { errors: child.errors.full_messages }.to_json, status: 422
      end
    end

    # PATCH/PUT /children/1
    def update
      child = Child.find(params[:id])

      if child.update(child_params)
        render json: child
      else
        render json: { errors: child.errors.full_messages }.to_json, status: :unprocessable_entity
      end
    end

    # DELETE /children/1
    def destroy
      child = Child.find(params[:id])
      child.destroy
      head :no_content
    end

    private
      # Never trust parameters from the scary internet, only allow the white list through.
      def child_params
        c_params = params.require(:child).permit(:manager_id, account_attributes:[:name,:email,:password,:password_confirmation])
        c_params[:account_attributes][:uid] = c_params[:account_attributes][:email]
        c_params[:account_attributes][:provider] = "email"
        c_params
      end
  end
end