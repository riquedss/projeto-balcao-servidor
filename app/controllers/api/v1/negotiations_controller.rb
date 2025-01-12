module Api
  module V1
    class NegotiationsController < ApplicationController
      before_action :set_advertisement, only: %i[ update create ]
      before_action :set_negotiation, only: %i[ update ]
      before_action :initialize_negotiation, only: :create

      def pending
        render(json: Api::V1::NegotiationsRepresenter.for_collection.new(Negotiation.pending.where(advertisement: current_user.advertisements)))
      end

      def create
        if @negotiation.save
          render(json: @negotiation, status: :created)
        else
          render(json: @negotiation.errors, status: :unprocessable_entity)
        end
      end

      def update
        case params[:status]
        when "confirmed"
          confirm_negotiation
        when "completed"
          complete_negotiation
        else
          render json: { error: "Invalid status." }, status: :unprocessable_entity
        end
      end

      private
      def initialize_negotiation
        @negotiation = @advertisement.negotiations.new(user: current_user, proposal: params[:proposal])
      end

      def set_advertisement
        @advertisement = Advertisement.find(params[:advertisement_id])
      end

      def set_negotiation
        @negotiation = Negotiation.find(params[:id])
      end

      def confirm_negotiation
        begin
          @negotiation.confirm!
          ChatService.start_chat_with_proposal(@negotiation.user, @negotiation.advertisement)
          render json: @negotiation, status: :ok
        rescue ActiveRecord::RecordInvalid => e
          render json: { error: e.record.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def complete_negotiation
        begin
          @negotiation.complete!
          render json: @negotiation, status: :ok
        rescue ActiveRecord::RecordInvalid => e
          render json: { error: e.record.errors.full_messages }, status: :unprocessable_entity
        end
      end
    end
  end
end
