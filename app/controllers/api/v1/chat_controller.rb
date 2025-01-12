module Api
  module V1
    class ChatController < ApplicationController
      before_action :set_user, only: %i[ send_message get_messages ]
      before_action :set_advertisement, only: %i[ send_message get_messages ]

      def send_message
        if ChatService.send_message(@user, @advertisement, params[:text])
          head :ok
        else
          head :unprocessable_entity
        end
      end

      def get_messages
        render(json: Message.where(user: @user, advertisement: @advertisement))
      end

      private

      def set_user
        @user = User.find(params[:user_id])
      end

      def set_advertisement
        @advertisement = Advertisement.find(params[:advertisement_id])
      end
    end
  end
end
