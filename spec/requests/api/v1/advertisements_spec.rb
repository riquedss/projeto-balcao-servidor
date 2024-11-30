require 'swagger_helper'

RSpec.describe 'api/v1/advertisements', type: :request do
  let(:user) { create(:user) }

  path '/api/v1/advertisements' do
    get('list advertisements') do
      response(200, 'successful') do
        xit
      end
    end

    post('create advertisement') do
      parameter name: :advertisement, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string },
          description: { type: :string },
          price: { type: :number },
          phone_contact: { type: :string },
          email_contact: { type: :string },
          user_id: { type: :string },
          images: { type: :array, items: { type: :string, format: :binary } }
        },
        required: [ 'title', 'description', 'price', 'phone_contact', 'email_contact', 'user_id' ]
      }

      response(201, 'created') do
        let(:advertisement) { create(:advertisement, user: user) }
        xit
      end

      response(422, 'unprocessable entity') do
        let(:advertisement) { { title: '' } }
        xit
      end
    end
  end

  path '/api/v1/advertisements/{id}' do
    parameter name: 'id', in: :path, type: :string, description: 'id'

    let(:advertisement) { create(:advertisement, user: user) }
    get('show advertisement') do
      response(200, 'successful') do
        xit
      end

      response(404, 'not found') do
        let(:id) { 'nonexistent' }
        xit
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
          user_id: { type: :string },
          images: { type: :array, items: { type: :string, format: :binary } }
        }
      }

      response(200, 'successful') do
        let(:advertisement) { create(:advertisement, user: user) }
        xit
      end

      response(422, 'unprocessable entity') do
        let(:advertisement) { create(:advertisement, user: user) }
        xit
      end
    end

    delete('delete advertisement') do
      response(204, 'no content') do
        xit
      end

      response(404, 'not found') do
        let(:advertisement) { create(:advertisement, user: user) }
        xit
      end
    end
  end
end
