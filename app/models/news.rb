class News < ActiveRecord::Base
  is_impressionable counter_cache: true
  belongs_to :user
  validates_presence_of :title, :body
  include HasImage
  extend FriendlyId
  friendly_id :title, use: :slugged

  def body
    self[:body].html_safe if self[:body]
  end

end