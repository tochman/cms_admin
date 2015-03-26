require_dependency 'cms_admin/application_controller'

module CmsAdmin
  class DashboardController < ::ApplicationController
    before_filter :authenticate_user!
    #before_action require_admin!
    layout 'cms_admin/admin'

    include CmsAdmin::ResponseRenderer

    def index
      request_response(:index)
    end

    private

  end
end

