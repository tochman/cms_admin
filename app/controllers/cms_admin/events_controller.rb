class Admin::EventsController < AdminController
  skip_before_action :verify_authenticity_token
  before_action :get_events

  respond_to :js, :json, :html
  layout false, only: [:new, :edit, :destroy, :update, :index]

  def index
    respond_to do |format|
      format.js {render action: :index, layout: false}
      format.html {render :index, layout: 'admin'}
    end
  end

  def new
    @event = Event.new
  end

  def destroy
    @event = Event.friendly.find(params[:id])
    @event.destroy
    flash.now[:notice] = 'Event Deleted'
    render action: :index
  end

  def edit
    @event = Event.friendly.find(params[:id])
  end

  def update
    @event = Event.friendly.find(params[:id])
    @event.update_attributes(event_params)
    flash.now[:notice] = 'Event Updated'
    render action: :index, layout: 'admin'
  end

  def create
    @event = Event.new(event_params)
    @event.user = current_user
    if @event.save
      flash.now[:notice] = 'Event created'
      render action: :index
    else
      flash.now[:error] = @event.errors.full_messages
      respond_to do |format|
        format.js {render action: :new, layout: false}
        format.html {render :new}
      end
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
