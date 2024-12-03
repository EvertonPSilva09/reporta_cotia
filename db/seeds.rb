# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Clear existing data
puts "Limpando dados existentes..."
Category.destroy_all
Address.destroy_all
Report.destroy_all
User.destroy_all

# Create users
puts "Criando usuários..."
users = User.create([
  { email: 'adm@example.com', password: 'password', role: :admin },
  { email: 'moderator@example.com', password: 'password', role: :moderator },
  { email: 'user3@example.com', password: 'password', role: :user },
  { email: 'user4@example.com', password: 'password', role: :user }
])
puts "Usuários criados: #{users.map(&:email).join(', ')}, a senha padrão é 'password'."

# Create categories
puts "Criando categorias..."
categories = Category.create([
  { name: 'basic_sanitation' },
  { name: 'infraestructure' },
  { name: 'paving' },
  { name: 'public_safety' },
  { name: 'street_lighting' }
])
puts "Categorias criadas: #{categories.map(&:name).join(', ')}"

# Create addresses
puts "Criando endereços..."
addresses = Address.create([
  { cep: '06703445', street: 'Rua Azulão', neighbhood: 'Jardim Nova Coimbra', city: 'Cotia', number: '86' },
  { cep: '06703420', street: 'Rua Avestruz', neighbhood: 'Jardim Nova Coimbra', city: 'Cotia', number: '21' },
  { cep: '06703370', street: 'Rua Beija-Flor', neighbhood: 'Jardim Nova Coimbra', city: 'Cotia', number: '175' },
  { cep: '06703190', street: 'Avenida Miguel Mirizola', neighbhood: 'Jardim Estela Mari', city: 'Cotia', number: '37' },
  { cep: '06703220', street: 'Rua Calógero Mirizola', neighbhood: 'Jardim Estela Mari', city: 'Cotia', number: '57' },
  { cep: '06703210', street: 'Rua Castanha', neighbhood: 'Jardim Estela Mari', city: 'Cotia', number: '156' }
])
puts "Endereços criados: #{addresses.map { |a| "#{a.street}, #{a.city}" }.join('; ')}"

# Create reports and associate them with addresses, categories, and users
puts "Criando relatórios..."
reports = Report.create([
  { title: 'Lâmpada queimada', description: 'Lâmpada do poste está queimada.', category: categories[0], address: addresses[0], user: users[2], status: :approved },
  { title: 'Buraco na rua', description: 'Há um buraco grande na rua.', category: categories[1], address: addresses[1], user: users[2] },
  { title: 'Vazamento de esgoto', description: 'Esgoto vazando na calçada.', category: categories[2], address: addresses[2], user: users[3] }
])
puts "Relatórios criados: #{reports.map(&:title).join(', ')}"

puts "Seed concluído com sucesso!"