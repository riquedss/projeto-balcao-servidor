# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

user = User.create!(
  full_name: Faker::Name.name,
  cpf: "772.859.910-07",
  email: Faker::Internet.email(domain: "id.uff.br")
)

10.times do
  Advertisement.create!(
    title: Faker::Book.title,
    description: Faker::Lorem.paragraph(sentence_count: 8),
    price: Faker::Number.decimal(l_digits: 4),
    phone_contact: Faker::PhoneNumber.cell_phone_in_e164,
    email_contact: Faker::Internet.email,
    user: user
  )
end

puts "Usuário e 10 anúncios foram criados com sucesso!"