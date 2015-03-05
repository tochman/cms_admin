require_dependency 'cms_admin/application_controller'
module CmsAdmin
  class EventsController < ::ApplicationController
    skip_before_action :verify_authenticity_token
    before_action :get_events

    include CmsAdmin::ResponseRenderer

    respond_to :js, :json, :html
    #layout false, only: [:new, :edit, :destroy, :update, :index]

    def index
      request_response(:index)
    end

    def new
      @event = Event.new
    end

    def destroy
      @event = Event.friendly.find(params[:id])
      @event.destroy
      flash.now[:notice] = 'Event Deleted'
      request_response(:index)
    end

    def edit
      @event = Event.friendly.find(params[:id])
    end

    def update
      @event = Event.friendly.find(params[:id])
      @event.update_attributes(event_params)
      flash.now[:notice] = 'Event Updated'
      request_response(:index)
    end

    def create
      @event = Event.new(event_params)
      @event.user = current_user
      if @event.save
        flash.now[:notice] = 'Event created'
        request_response(:index)
      else
        flash.now[:error] = @event.errors.full_messages
        request_response(:new)
      end

    end


    private

    def get_events
      @events = Event.all.order('created_at DESC')
    end

    def event_params
      params.require(:event).permit(:title, :body, :user_id, :hero_image, :start_date, :end_date, :resource_url)
    end

  end
end

