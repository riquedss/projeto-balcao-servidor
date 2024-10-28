FactoryBot.define do
  factory :advertisement do
    title { Faker::Book.title }
    description { Faker::Lorem.paragraph(sentence_count: 8) }
    price { Faker::Number.decimal(l_digits: 4) }

    phone_contact { Faker::PhoneNumber.cell_phone_in_e164 }
    email_contact { Faker::Internet.email }
  end
end
