module API
  class ManagersController < ApplicationController
    # Add this line when authentication is in place
    #before_action :authenticate_account!

    # GET /managers
    def index
      render json: Manager.all
    end

    # GET /managers/1
    def show
      render json: Manager.find(params[:id])
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

    # PATCH/PUT /managers/1
    def update
      manager = Manager.find(params[:id])

      if manager.update(manager_params)
        render json: manager
      else
        render json: { errors: manager.errors.full_messages }.to_json, status: :unprocessable_entity
      end
    end

    # DELETE /managers/1
    def destroy
      manager = Manager.find(params[:id])
      manager.destroy
      head :no_content
    end

    private
      # Never trust parameters from the scary internet, only allow the white list through.
      def manager_params
        m_params = params.require(:manager).permit(account_attributes:[:name,:email,:password,:password_confirmation])
        m_params[:account_attributes][:uid] = m_params[:account_attributes][:email]
        m_params[:account_attributes][:provider] = "email"
        m_params
      end
  end
end