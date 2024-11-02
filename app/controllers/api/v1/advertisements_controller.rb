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
        @advertisement = Advertisement.new(params_advertisement)
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

      def mock
        body = params.permit(:number_generate_advertisement)

        unless body["number_generate_advertisement"].is_a? Integer
          return render(json: { message: "'number_generate_advertisement' must exist and be a number" }, status: :bad_request)
        end

        body["number_generate_advertisement"].times do
          Advertisement.create!(
            title: Faker::Book.title,
            description: Faker::Lorem.paragraph(sentence_count: 8),
            price: Faker::Number.decimal(l_digits: 4),
            phone_contact: Faker::PhoneNumber.cell_phone_in_e164,
            email_contact: Faker::Internet.email,
            user: set_user
          )
        end

        head(:ok)
      end

      def destroy
        @advertisement.destroy
      end

      private

      def params_advertisement
        params.permit(:title, :description, :price, :phone_contact, :email_contact, :user_id)
      end

      def set_advertisement
        @advertisement = Advertisement.find(params[:id])
      end

      def set_user
        User.first || User.create!(full_name: Faker::Name.name, cpf: "772.859.910-07", email: Faker::Internet.email(domain: "id.uff.br"))
      end
    end
  end
end
