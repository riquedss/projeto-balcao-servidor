class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  before_action :authenticate_api_v1_user!, unless: :public_action?
  before_action :configure_permitted_parameters, if: :devise_controller?

  def current_user
    current_api_v1_user
  end

  rescue_from CanCan::AccessDenied do
    head :forbidden
  end

  protected

  def configure_permitted_parameters
    allowed_parameters = %i[full_name]
    devise_parameter_sanitizer.permit(:sign_up, keys: allowed_parameters)
    devise_parameter_sanitizer.permit(:account_update, keys: allowed_parameters)
  end

  def public_action?
    devise_controller? && %w[create sign_in].include?(action_name)
  end
end
