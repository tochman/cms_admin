module CmsAdmin
  class NewsController < ::ApplicationController
    skip_before_action :verify_authenticity_token
    before_action :get_news

    respond_to :js, :json, :html
    layout false, only: [:new, :edit, :destroy, :update, :index]

    def index
    end

    def new
      @news = News.new
    end

    def destroy
      @news = News.friendly.find(params[:id])
      @news.destroy
      flash.now[:notice] = 'News item Deleted'
      render action: :index
    end

    def edit
      @news = News.friendly.find(params[:id])
    end

    def update
      @news = News.friendly.find(params[:id])
      @news.update_attributes(news_params)
      flash.now[:notice] = 'News item Updated'
      render action: :index, layout: 'admin'
    end

    def create
      @news = News.new(news_params)
      @news.user = current_user
      if @news.save
        flash.now[:notice] = 'News item created'
        render action: :index
      else
        flash.now[:error] = @news.errors.full_messages
        respond_to do |format|
          format.js { render action: :new, layout: false }
          format.html { render :new }
        end
      end
    end

    private

    def get_news
      @news_set = News.all.order('created_at DESC')
    end

    def news_params
      params.require(:news).permit(:title, :body, :user_id, :hero_image)
    end


  end
end
