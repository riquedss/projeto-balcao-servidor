RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
  Faker::Config.locale = 'pt-BR'
end
