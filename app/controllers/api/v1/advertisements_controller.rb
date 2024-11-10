module Api
  module V1
    class AdvertisementsController < ApplicationController
      before_action :set_advertisement, only: %i[show update destroy]

      def index
        render(json: Advertisement.all)
      end

      def show
        render(json: @advertisement)
      end

      def create
        @advertisement = Advertisement.new(params_advertisement.except(:images))
        @advertisement.attach_images(params[:images]) if params[:images].present?

        if @advertisement.save
          render(json: @advertisement, status: :created)
        else
          render(json: @advertisement.errors, status: 422)
        end
      end

      def update
        if @advertisement.update(params_advertisement)
          render(json: @advertisement, status: :ok)
        else
          render(json: @advertisement.errors, status: :not_foud)
        end
      end

      def destroy
        @advertisement.destroy
      end

      private

      def params_advertisement
        params.permit(:title, :description, :price, :phone_contact, :email_contact, :user_id, images: [])
      end

      def set_advertisement
        @advertisement = Advertisement.find(params[:id])
      end
    end
  end
end
