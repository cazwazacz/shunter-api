require 'parliament'
require 'pugin/helpers/controller_helpers'
require 'parliament/utils'

class ApplicationController < ActionController::API
  include Pugin::Helpers::ControllerHelpers
  include Parliament::Utils::Helpers::ApplicationHelper
  include Parliament::Utils::Helpers::VCardHelper
  include ActionController::MimeResponds
  include PageSerializer
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # prpotect_from_forgery with: :exception

  # layout 'pugin/layouts/pugin'

  # Controller helper methods available from Pugin::Helpers::ControllerHelpers
  #
  # Used to turn Pugin Features on and off at a controller level
  before_action :reset_bandiera_features, :enable_top_navigation, :enable_global_search, :enable_status_banner, :reset_alternates, :disable_pingdom, :disable_asset_overrides

  # Rescues from a Parliament::ClientError and raises an ActionController::RoutingError
  rescue_from Parliament::ClientError do |error|
    raise ActionController::RoutingError, error.message
  end

  # Rescues from a Parliament::NoContentResponseError and raises an ActionController::RoutingError
  rescue_from Parliament::NoContentResponseError do |error|
    raise ActionController::RoutingError, error.message
  end

  def render_page(serializer)
    response.headers['Content-Type'] = 'application/x-shunter+json'
    response.headers['Access-Control-Allow-Origin'] = '*'
    response.headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
    response.headers['Access-Control-Request-Method'] = '*'
    response.headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'

    render json: serializer.to_h
  end
end
