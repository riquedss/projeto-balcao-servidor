FactoryBot.define do
  factory :user do
    full_name { Faker::Name.name }
    cpf { '772.859.910-07' }
    email { Faker::Internet.email(domain: 'id.uff.br') }
  end
end
