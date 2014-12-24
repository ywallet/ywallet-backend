class RulesController < ApplicationController

  authorize_resource

=begin
  def index
    render json: Rule.all
  end
=end

  # GET /rules/1
  def show
    rule = Rule.find(params[:id])
    if can? :read, rule
      render json: rule
    else
      render json: { errors: "You can't access this rule" }, status: 403
    end
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
      params.require(:rule).permit(:active, :notifies, :wallet_id)
    end
end