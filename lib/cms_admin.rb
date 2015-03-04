require 'cms_admin/engine'
require 'cms_admin/routes'

module CmsAdmin
  module ErrorHandler
    extend ActiveSupport::Concern

    included do
      rescue_from ActiveRecord::RecordNotFound do |exception|
        render_404
      end

      rescue_from ActionView::MissingTemplate do |exception|
        render_404
      end

      rescue_from CmsAdmin::Errors::RoutingError do |exception|
        render_404
      end

      rescue_from ActionController::InvalidAuthenticityToken do |exception|
        render_422
      end
    end

    protected

    def render_404(exception = nil)
      byebug
      if exception then
        logger.info("Rendering 404 with exception: #{exception.message}")
      else
        logger.info 'Rendering 404'
      end
      respond_to do |format|
        format.html { byebug; render file: "#{Rails.root}/public/404", formats: [:html], status: :not_found, layout: true }
      end
    end

    def render_422(exception = nil)
      if exception then
        logger.info "Rendering 402 with exception: #{exception.message}"
      else
        logger.info 'Rendering 404'
      end
      respond_to do |format|
        format.html { render file: "#{Rails.root}/public/422", formats: [:html], status: :unprocessable_entity, layout: true }

      end
    end

  end

  module Errors
    class RoutingError < StandardError

    end
  end
end
