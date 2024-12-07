class Advertisement < ApplicationRecord
  include Rails.application.routes.url_helpers

  belongs_to :user
  has_many :negotiations, dependent: :restrict_with_exception
  has_many :messages, dependent: :restrict_with_exception

  has_many_attached :images

  def attach_images(images_base64)
    if images_base64.present?
      images_base64.each do |image_base64|
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
    images.map { |image| api_v1_url(image.id) }
  end
end
