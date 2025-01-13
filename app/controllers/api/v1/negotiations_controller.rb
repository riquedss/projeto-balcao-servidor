module Api
  module V1
    class NegotiationsController < ApplicationController
      before_action :set_advertisement
      before_action :set_negotiation, only: %i[update]
      before_action :initialize_negotiation, only: :create

      def index
        my_negotiations = Negotiation.where.not(status: :pending).where(user: current_user)
        my_negotiations += Negotiation.joins(:advertisement).where.not(status:  "pending").where("advertisement.user_id" => current_user)

        render(json: my_negotiations)
      end

      def create
        if @negotiation.save
          render(json: @negotiation, status: :created)
        else
          render(json: @negotiation.errors, status: :unprocessable_entity)
        end
      end

      def update
        byebug
        case params[:status]
        when "confirmed"
          confirm_negotiation
        when "completed"
          byebug
          complete_negotiation
        else
          render json: { error: "Invalid status." }, status: :unprocessable_entity
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
          byebug
          @negotiation.complete!
          render json: @negotiation, status: :ok
        rescue ActiveRecord::RecordInvalid => e
          render json: { error: e.record.errors.full_messages }, status: :unprocessable_entity
        end
      end
    end
  end
end
