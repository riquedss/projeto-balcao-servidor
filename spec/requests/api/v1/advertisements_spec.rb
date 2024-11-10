require 'swagger_helper'

RSpec.describe 'api/v1/advertisements', type: :request do
  path '/api/v1/advertisements' do
    get('list advertisements') do
      response(200, 'successful') do
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    path '/api/v1/advertisements' do
      post('create advertisement') do
        parameter name: :advertisement, in: :body, schema: {
          type: :object,
          properties: {
            title: { type: :string },
            description: { type: :string },
            price: { type: :number },
            phone_contact: { type: :string },
            email_contact: { type: :string },
            user_id: { type: :integer },
            images: { type: :array, items: { type: :string, format: :binary } }
          },
          required: ['title', 'description', 'price', 'phone_contact', 'email_contact', 'user_id']
        }
        response(201, 'created') do
          let(:advertisement) do
            {
              title: 'Sample Ad',
              description: 'This is a sample advertisement.',
              price: 100.0,
              phone_contact: '123456789',
              email_contact: 'example@example.com',
              user_id: 1,
              images: []
            }
          end
          after do |example|
            example.metadata[:response][:content] = {
              'application/json' => {
                example: JSON.parse(response.body, symbolize_names: true)
              }
            }
          end
          run_test!
        end

        response(422, 'unprocessable entity') do
          let(:advertisement) { { title: '' } }
          run_test!
        end
      end
    end
  end

  path '/api/v1/advertisements/{id}' do
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show advertisement') do
      response(200, 'successful') do
        let(:id) { Advertisement.create!(title: 'Sample Ad', description: 'Sample description', price: 100).id }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end

      response(404, 'not found') do
        let(:id) { 'nonexistent' }
        run_test!
      end
    end

    patch('update advertisement') do
      parameter name: :advertisement, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string },
          description: { type: :string },
          price: { type: :number },
          phone_contact: { type: :string },
          email_contact: { type: :string },
          user_id: { type: :integer },
          images: { type: :array, items: { type: :string, format: :binary } }
        }
      }

      response(200, 'successful') do
        let(:id) { Advertisement.create!(title: 'Sample Ad', description: 'Sample description', price: 100).id }
        let(:advertisement) { { title: 'Updated Title' } }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end

      response(422, 'unprocessable entity') do
        let(:id) { Advertisement.create!(title: 'Sample Ad', description: 'Sample description', price: 100).id }
        let(:advertisement) { { title: '' } } # Invalid data
        run_test!
      end
    end

    put('update advertisement') do
      parameter name: :advertisement, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string },
          description: { type: :string },
          price: { type: :number },
          phone_contact: { type: :string },
          email_contact: { type: :string },
          user_id: { type: :integer },
          images: { type: :array, items: { type: :string, format: :binary } }
        }
      }

      response(200, 'successful') do
        let(:id) { Advertisement.create!(title: 'Sample Ad', description: 'Sample description', price: 100).id }
        let(:advertisement) { { title: 'Updated Title' } }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end

      response(422, 'unprocessable entity') do
        let(:id) { Advertisement.create!(title: 'Sample Ad', description: 'Sample description', price: 100).id }
        let(:advertisement) { { title: '' } }
        run_test!
      end
    end

    delete('delete advertisement') do
      response(204, 'no content') do
        let(:id) { Advertisement.create!(title: 'Sample Ad', description: 'Sample description', price: 100).id }
        run_test!
      end

      response(404, 'not found') do
        let(:id) { 'nonexistent' }
        run_test!
      end
    end
  end
end
