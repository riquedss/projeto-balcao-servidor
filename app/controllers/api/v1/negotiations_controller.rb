module Api
    module V1
        class NegotiationsController < ApplicationController
            before_action :set_advertisement
            before_action :set_negotiation, only: %i[show update destroy]
            before_action :initialize_negotiation, only: :create
            authorize_resource except: %i[index show]

            def create
                if @negotiation.save
                render(json: @negotiation, status: :created)
                else
                render(json: @negotiation.errors, status: :unprocessable_entity)
                end
            end

            def update
                if @negotiation.update(params_negotiation)
                render(json: @negotiation, status: :ok)
                else
                render(json: @negotiation.errors, status: :not_foud)
                end
            end

            def destroy
                @negotiation.destroy
            end

            private

            def params_negotiation
                params.permit(:title, :description, :price, :campus, :category, :kind, :phone_contact, :email_contact, :user_id, images: [])
            end

            def initialize_negotiation
                @negotiation = @advertisement.negotiations.new(params_negotiation.merge(user: current_user))
              end

            def set_advertisement
                @advertisement = Advertisement.find_by(params[:advertisement_id])
            end

            def set_negotiation
                @negotiation = Negotiation.find(params[:id])
            end
        end
    end
end
