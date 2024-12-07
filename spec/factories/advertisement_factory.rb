FactoryBot.define do
  factory :advertisement do
    title { Faker::Book.title }
    description { Faker::Lorem.paragraph(sentence_count: 8) }
    price { Faker::Number.decimal(l_digits: 5, r_digits: 3) }
    category { Random.rand(Advertisement.categories.count) }
    campus { Random.rand(Advertisement.categories.count) }

    phone_contact { "7198667-8909" }
    email_contact { Faker::Internet.email(domain: "id.uff.br") }
  end
end
