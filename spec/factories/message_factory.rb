FactoryBot.define do
  factory :message do
    text { Faker::Lorem.paragraph(sentence_count: 2) }
  end
end
