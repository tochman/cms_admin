require 'cms_admin/engine'


module CmsAdmin
  module ErrorHandler
    extend ActiveSupport::Concern

    included do
      rescue_from ActiveRecord::RecordNotFound do |exception|
        render_404(exception)
      end

      rescue_from ActionView::MissingTemplate do |exception|
        render_404(exception)
      end

      rescue_from ActionController::RoutingError do |exception|
        render_404(exception)
      end

      rescue_from ActionController::InvalidAuthenticityToken do |exception|
        render_422(exception)
      end
    end


    protected

    def render_404(exception)
      if exception then
        logger.info("Rendering 404 with exception: #{exception.message}")
      else
        logger.info 'Rendering 404'
      end
      respond_to do |format|
        format.html { render file: "#{Rails.root}/public/404", formats: [:html], status: :not_found, layout: true }
        format.all { render nothing: true, status: 404 }
      end
    end

    def render_422(exception)
      if exception then
        logger.info "Rendering 422 with exception: #{exception.message}"
      else
        logger.info 'Rendering 422'
      end
      respond_to do |format|
        format.html { render file: "#{Rails.root}/public/422", formats: [:html], status: :unprocessable_entity, layout: true }
        format.all { render nothing: true, status: 422 }

      end
    end
  end


  module ResponseRenderer
    def request_response(action)
      respond_to do |format|
        format.js { render action: action, layout: false }
        format.html { render action, layout: 'cms_admin/admin' }
      end
    end
  end

end



