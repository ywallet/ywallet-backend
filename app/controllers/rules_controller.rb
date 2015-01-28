class RulesController < ApplicationController

  authorize_resource

  swagger_controller :rules, "Rules Management"

=begin
  def index
    render json: Rule.all
  end
=end

  swagger_api :show do
    summary "Fetches a single rule"
    param :path, :id, :integer, :required, "Rule ID"
    response :ok, "Success", :Rule
    response :forbidden, "You can't access this rule"
  end

  # GET /rules/1
  def show
    rule = Rule.find(params[:id])
    if can? :read, rule
      render json: rule
    else
      render json: { errors: "You can't access this rule" }, status: 403
    end
  end

  swagger_api :create do
    summary "Create a single Rule"
    param :form, :rule, :string, :required, "Rule object containing params"
    param :form, :active, :string, :required, "rule[:active]"
    param :form, :notifies, :string, :required, "rule[:notifies]"
    param :form, :account_id, :integer, :required, "rule[:account_id]"
    response :created, "Created", :Rule
    response :unprocessable_entity, "Unprocessable Entity"
    response :forbidden, "You can't create a rule for this wallet."
  end

  # POST /rules
  def create
    rule = Rule.new(rule_params)

    if can? :create, rule
      rule.save
      if rule.persisted?
        render json: rule, status: 201
      else
        render json: { errors: rule.errors.full_messages }.to_json, status: 422
      end
    else
      render json: { errors: "You can't create a rule for this wallet." }, status: 403
    end
  end

  swagger_api :update do
    summary "Update information on a Rule"
    param :path, :id, :integer, :required, "Rule ID"
    param :form, :rule, :string, :required, "Rule object containing params"
    param :form, :active, :string, :optional, "rule[:active]"
    param :form, :notifies, :string, :optional, "rule[:notifies]"
    param :form, :account_id, :string, :optional, "account_attributes[:account_id]"
    response :ok, "Success", :Rule
    response :unprocessable_entity, "Unprocessable Entity"
    response :forbidden, "You can't access this manager"
  end

  # PATCH/PUT /rules/1
  def update
    rule = Rule.find(params[:id])

    if can? :update, rule

      if rule.update(rule_params)
        render json: rule
      else
        render json: { errors: rule.errors.full_messages }.to_json, status: :unprocessable_entity
      end

    else
      render json: { errors: "You can't update this rule" }, status: 403
    end
  end

  # DELETE /rules/1
  def destroy
    rule = Rule.find(params[:id])

    if can? :destroy, rule
      rule.destroy
      head :no_content
    else
      render json: { errors: "You can't destroy this rule" }, status: 403
    end
  end

  private
    def rule_params
      params.require(:rule).permit(:active, :notifies, :account_id)
    end
end