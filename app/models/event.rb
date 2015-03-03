class Event < ActiveRecord::Base
  is_impressionable counter_cache: true
  belongs_to :user
  validates_presence_of :title, :body
  validates_format_of :resource_url,
                      with: /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix,
                      multiline: true,
                      allow_blank: true

  include HasImage
  extend FriendlyId
  friendly_id :title, use: :slugged

  after_create do
    self.start_date = Time.now if self.start_date.blank?
    self.end_date = Time.now if self.end_date.blank?
    self.save!
  end

  def body
    self[:body].html_safe if self[:body]
  end
end
