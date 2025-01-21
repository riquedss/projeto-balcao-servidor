module Api
  module V1
    class StorageBlobController < ApiController
      def download
        send_data(ActiveStorage::Attachment.find(params[:id]).download, content_type: "image/png")
      end
    end
  end
end
