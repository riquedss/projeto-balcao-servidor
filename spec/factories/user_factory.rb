FactoryBot.define do
  factory :user do
    full_name { Faker::Name.name }
    cpf { "772.859.910-07" }
    email { Faker::Internet.email(domain: "id.uff.br") }

    password_faker = Faker::Internet.password(min_length: 8)
    password { password_faker }
    password_confirmation { password_faker }

    trait :admin do
      role { 1 }
    end

    trait :cpf_alternativo do
      cpf { "436.779.650-71" }
    end
  end
end
