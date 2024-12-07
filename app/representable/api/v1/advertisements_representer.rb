module Api
  module V1
    class AdvertisementsRepresenter < Representable::Decorator
      include Representable::JSON

        property :id
        property :title
        property :description
        property :price
        property :status
        property :category
        property :campus
        property :phone_contact
        property :email_contact
        property :images_urls
        property :created_at
        property :updated_at

        property :user do
          property :full_name
          property :rating
        end
    end
  end
end
