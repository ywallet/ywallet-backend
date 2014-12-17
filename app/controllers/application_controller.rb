class ApplicationController < ActionController::Base
	include DeviseTokenAuth::Concerns::SetUserByToken
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception
	skip_before_filter  :verify_authenticity_token

	alias_method :current_user, :current_account
	
	respond_to :json

	rescue_from CanCan::AccessDenied do |exception|
   		render json: { errors: exception.message }.to_json, status: 401
  	end
end
