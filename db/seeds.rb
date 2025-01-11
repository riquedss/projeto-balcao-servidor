# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
NUMERO_ADVERTISEMENT = 10

user_login = User.create!(
  full_name: Faker::Name.name,
  cpf: "772.859.910-71",
  email: Faker::Internet.email(domain: "id.uff.br"),
  rating: 4.6,
  password: "password123",
  password_confirmation: "password123"
)

user_advertisements = User.create!(
  full_name: Faker::Name.name,
  cpf: "046.964.490-76",
  email: Faker::Internet.email(domain: "id.uff.br"),
  rating: 4.6,
  password: "password123",
  password_confirmation: "password123"
)

NUMERO_ADVERTISEMENT.times do
  price = Faker::Number.decimal(l_digits: 4, r_digits: 3)
  kind = Random.rand(Advertisement.kinds.count)

  Advertisement.create!(
    title: Faker::Book.title,
    description: Faker::Lorem.paragraph(sentence_count: 8),
    price: kind == 1 ? price : nil,
    status: Random.rand(Advertisement.statuses.count),
    kind: kind,
    category: Random.rand(Advertisement.categories.count),
    campus: Random.rand(Advertisement.campus.count),
    phone_contact: "7198667-8909",
    email_contact: Faker::Internet.email(domain: "id.uff.br"),
    user: user_advertisements
  )
end

puts "Usuários e #{NUMERO_ADVERTISEMENT} anúncios foram criados com sucesso!"
