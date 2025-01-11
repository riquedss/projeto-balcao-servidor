module Api
  module V1
    class AdvertisementsController < ApplicationController
      before_action :set_advertisement, only: %i[show update destroy]
      before_action :initialize_advertisement, only: :create
      authorize_resource except: %i[index show]

      def index
        query_parameters = request.query_parameters
        if query_parameters[:my] == "true"
          my_advertisement = Advertisement.joins(:negotiations)
                            .where("negotiations.status" => "completed", "negotiations.user_id" => current_user)
          my_advertisement += current_user.advertisements

          render(json: Api::V1::AdvertisementsRepresenter.for_collection.new(my_advertisement))
        else
          render(json: PaginationAdvertisementService.process_query(Advertisement, query_parameters))
        end
      end

      def show
        render(json: Api::V1::AdvertisementsRepresenter.new(@advertisement))
      end

      def create
        if @advertisement.save
          render(json: Api::V1::AdvertisementsRepresenter.new(@advertisement), status: :created)
        else
          render(json: @advertisement.errors, status: :unprocessable_entity)
        end
      end

      def update
        if @advertisement.update(params_advertisement)
          render(json: Api::V1::AdvertisementsRepresenter.new(@advertisement), status: :ok)
        else
          render(json: @advertisement.errors, status: :not_foud)
        end
      end

      def destroy
        @advertisement.destroy
      end

      private

      def params_advertisement
        params.permit(:title, :description, :price, :campus, :category, :kind, :phone_contact, :email_contact, :user_id, images: [])
      end

      def initialize_advertisement
        @advertisement = Advertisement.new(params_advertisement.except(:images))
        @advertisement.attach_images(params[:images]) if params[:images].present?
      end

      def set_advertisement
        @advertisement = Advertisement.find(params[:id])
      end
    end
  end
end
