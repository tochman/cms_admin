module Admin::DashboardHelper
  def stats
    {events: Event.count, news: News.count}
  end

  def most_viewed_events
    impressions = Event.where('impressions_count > 0').limit(10).group(:title).count
    get_html(impressions)
  end

  def most_viewed_news
    impressions = News.where('impressions_count > 0').limit(10).group(:title).count
    get_html(impressions)
  end

  def page_views
    impressions = Impression.where(controller_name: 'pages').group(:action_name).count
    get_html(impressions)
  end

  def get_html(impressions)
    content_tag :div do
      impressions.each do |k, v|
        concat(content_tag :p, [k.humanize, 'has', v, (v == 1 ? 'impression' : 'impression'.pluralize)].join(' '))
      end
    end
  end

end

