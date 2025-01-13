class Advertisement < ApplicationRecord
  include Rails.application.routes.url_helpers

  has_many_attached :images

  belongs_to :user
  has_many :negotiations, dependent: :restrict_with_exception

  enum :status, %i[ ativo passado ]
  enum :kind, %i[ busca oferta_item ]
  enum :category, %i[ livro roupa movel aula_particular ]
  enum :campus, %i[ praia_vermelha gragoata valonguinho santo_antonio_padua campos_goytacazes ]

  validates :title, :category, :campus, :kind, presence: true
  validates :price, presence: true, if: -> { oferta_item? }
  validates :email_contact, format: { with: REGEX_EMAIL }
  validates :phone_contact, format: { with: REGEX_PHONE }

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

  def self.filter_categories(key)
    where(category: Advertisement.categories[key]) unless key.blank?
  end

  def self.filter_kinds(key)
    where(kind: Advertisement.kinds[key]) unless key.blank?
  end

  def self.filter_campus(key)
    where(campus: Advertisement.campus[key]) unless key.blank?
  end

  def self.filter_statuses(key)
    where(status: Advertisement.statuses[key]) unless key.blank?
  end

  def self.filter_price(min_price, max_price = nil)
    return nil if min_price.blank?

    unless max_price.blank?
      where("price >= ? AND price <= ?", min_price.to_f, max_price.to_f)
    else
      where("price = ?", min_price.to_f)
    end
  end

  def self.filter_date(min_date, max_date = nil)
    return nil if min_date.blank?

    unless max_date.blank?
      where("created_at >= ? AND created_at <= ?", min_date, max_date)
    else
      where("created_at = ?", min_date)
    end
  end

  def self.date_valid?(date)
    date.to_date
  rescue
    false
  end
end
