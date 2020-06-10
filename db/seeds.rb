# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Role.find_or_create_by(id: '00000000-0000-0000-0000-000000012000', name: "super_admin")
Role.find_or_create_by(id: '00000000-0000-0000-0000-000000012001', name: "admin")
Role.find_or_create_by(id: '00000000-0000-0000-0000-000000012002', name: "customer")

# Role.find_or_create_by(id: '00000000-0000-0000-0000-000000012001',name: "")

user = User.where(email: 'super_admin@pakata.co').first_or_initialize
user.update(first_name: 'Super', last_name: 'Admin', password: 'pakata123')
user.add_role :super_admin
