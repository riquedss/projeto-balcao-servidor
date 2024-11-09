class Advertisement < ApplicationRecord
  before_save :attach_images

  belongs_to :user
  has_many :negotiations, dependent: :restrict_with_exception
  has_many :messages, dependent: :restrict_with_exception

  has_many_attached :images

  def attach_images
    if !images.nil?
      self.images.each do |image_base64|
        image_data = Base64.decode64(image_base64)
        @advertisement.images.attach(
          io: StringIO.new(image_data),
          filename: "advertisement_#{Time.now.to_i}.png",
          content_type: "image/png"
        )
      end
    end
  end
end
