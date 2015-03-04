module CmsAdmin
  class DashboardController < ::ApplicationController
    layout 'cms_admin/admin'

    def index
      respond_to do |format|
        format.js { render action: :index, layout: false }
        format.html { render :index, layout: 'cms_admin/admin' }
      end
    end

    private

  end
end

