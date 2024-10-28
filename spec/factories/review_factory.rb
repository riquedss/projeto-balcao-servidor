FactoryBot.define do
  factory :review do
    rating { Faker::Number.between(from: 1, to: 5) }
    comments { Faker::Lorem.paragraph(sentence_count: 4) }
  end
end
