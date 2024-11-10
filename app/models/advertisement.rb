class Advertisement < ApplicationRecord
  include Rails.application.routes.url_helpers
  
  before_save :attach_images

  belongs_to :user
  has_many :negotiations, dependent: :restrict_with_exception
  has_many :messages, dependent: :restrict_with_exception

  has_many_attached :images

  def attach_images
    if images.present?
      images.each do |image_base64|
        image_data = Base64.decode64(image_base64)
        images.attach(
          io: StringIO.new(image_data),
          filename: "advertisement_#{Time.now.to_i}.png",
          content_type: "image/png"
        )
      end
    end
  end

  def images_urls
    images.map { |image| rails_blob_url(image, only_path: false) }
  end

  def as_json(options = {})
    super(options.merge({
      include: { images: { only: [] } },
      methods: :images_urls
    }))
  end
end
