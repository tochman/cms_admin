module CmsAdmin
  class DashboardController < ::ApplicationController
    layout false


    def index
      respond_to do |format|
        format.js { render action: :index, layout: false }
        format.html { render :index, layout: 'admin' }
      end
    end

    private


  end
end

