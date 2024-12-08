module Api
    module V1
        class NegotiationsController < ApplicationController
            before_action :set_advertisement
            before_action :set_negotiation, only: %i[update]
            before_action :initialize_negotiation, only: :create

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

            private

            def initialize_negotiation
                @negotiation = @advertisement.negotiations.new(user: current_user)
              end

            def set_advertisement
                @advertisement = Advertisement.find(params[:advertisement_id])
            end

            def set_negotiation
                @negotiation = Negotiation.find(params[:id])
            end
        end
    end
end
