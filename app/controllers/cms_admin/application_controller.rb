module CmsAdmin
  class ApplicationController < ActionController::Base
    include CmsAdmin::ErrorHandler


    def logger
      render_404
    end
  end
end
