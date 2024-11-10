require 'swagger_helper'

RSpec.describe 'api/v1/advertisements', type: :request do
  let!(:user) do
    User.create!(
      full_name: Faker::Name.name,
      cpf: "772.859.910-07",
      email: Faker::Internet.email(domain: "id.uff.br")
    )
  end

  before do
    allow_any_instance_of(Advertisement).to receive(:save).and_return(true)
    allow_any_instance_of(Advertisement).to receive(:destroy).and_return(true)
  end

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
        required: ['title', 'description', 'price', 'phone_contact', 'email_contact', 'user_id' ]
      }

      response(201, 'created') do
        let(:advertisement) do
          {
            title: 'Sample Ad',
            description: 'This is a sample advertisement.',
            price: 100.0,
            phone_contact: '123456789',
            email_contact: 'example@example.com',
            user_id: user.uuid,
            images: []
          }
        end
        xit
      end
    end
  end

  path '/api/v1/advertisements/{id}' do
    parameter name: 'id', in: :path, type: :string, description: 'id'

    let(:id) { Advertisement.create!(title: 'Sample Ad', description: 'Sample description', price: 100).id }

    get('show advertisement') do
      response(200, 'successful') do
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
        let(:advertisement) { { title: 'Updated Title' } }
        xit
      end
    end

    delete('delete advertisement') do
      response(204, 'no content') do
        xit
      end
    end
  end
end
