module HasImage
  extend ActiveSupport::Concern
  #We can access the resource with i e hero_image.instance

  included do
    has_attached_file :hero_image,
                      styles: {large: '350x350>', medium: '247x247#', thumb: '100x100#'},
                      convert_options: {all: Proc.new{HasImage.convert_options}},
                      default_url: 'images/no-image.png'
    before_post_process :check_file_size
    validates_attachment :hero_image, content_type: {content_type: %w(image/jpeg image/gif image/png)}
    validates :hero_image, attachment_presence: false
    unless Rails.env.test?
      validates_with Paperclip::Validators::AttachmentPresenceValidator, attributes: :hero_image
      validates_with Paperclip::Validators::AttachmentSizeValidator, attributes: :hero_image, less_than: 10.megabytes
    end
  end

  def self.convert_options(px = 1)
    trans = ""
    #Remove transparency
    #trans << "\\-background white -alpha remove"
    #Add border
    trans << "\\-bordercolor white -border 5"
    #Add rounded corners
    trans << " \\( +clone  -alpha extract "
    trans << "-draw 'fill black polygon 0,0 0,#{px} #{px},0 fill white circle #{px},#{px} #{px},0' "
    trans << "\\( +clone -flip \\) -compose Multiply -composite "
    trans << "\\( +clone -flop \\) -compose Multiply -composite "
    trans << "\\) -alpha off -compose CopyOpacity -composite "
    #Drop a shadow around image
    #trans << " \\( +clone -background black -shadow 100x3+0+0  \\) +swap -background none -layers merge +repage"

  end

  def check_file_size
    valid?
    errors[:image_file_size].blank?
  end

end