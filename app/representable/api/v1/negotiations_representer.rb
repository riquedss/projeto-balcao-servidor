module Api
  module V1
    class NegotiationsRepresenter < Representable::Decorator
      include Representable::JSON

        property :proposal
        property :status
        property :created_at
        property :updated_at

        property :user do
          property :id
          property :full_name
          property :rating
        end

        property :advertisement, extend: AdvertisementsRepresenter, class: ::Advertisement
        collection_representer class: ::Negotiation
    end
  end
end
