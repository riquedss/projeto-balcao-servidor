module Api
    module V1
        class ReviewController < ApplicationController
            before_action :set_review, only: %i[show update destroy]
            before_action :initialize_review, only: :create
            authorize_resource except: %i[index show]

            def index
                render(json: PaginationService.process_query(Review, request.query_parameters))
            end

            def create
                if @review.save
                    render(json: @review, status: :created)
                else
                    render(json: @review.errors, status: :unprocessable_entity)
                end
            end

            private

            def params_review
                params.permit(:user_id, :negotiation_id, :rating, :comments)
            end

            def initialize_review
                @advertisement = Review.new(params_review)
            end

            def set_review
                @review = Review.find(params[:id])
            end

            def set_user
                @user = User.find(params[:user_id])
            end
        end
    end
end
