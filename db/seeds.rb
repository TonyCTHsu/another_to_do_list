# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

List.create(name: 'Published list with published items').tap do |l|
  l.list_items.create(description: 'Real Madrid')
  l.list_items.create(description: 'Barcelona')
end

List.create(name: 'Published list with partial published items').tap do |l|
  l.list_items.create(description: 'Man City')
  l.list_items.create(description: 'Man Utd', publish: false)
end

List.create(name: 'Published list with unpublished items').tap do |l|
  l.list_items.create(description: 'Arsenal', publish: false)
  l.list_items.create(description: 'Chelsea', publish: false)
end

List.create(name: 'Unpublished list with published items', publish: false).tap do |l|
  l.list_items.create(description: 'Liverpool')
  l.list_items.create(description: 'Tottenham Hotspurs')
end

List.create(name: 'Unpublished list partial published items', publish: false).tap do |l|
  l.list_items.create(description: 'Bayern Munich')
  l.list_items.create(description: 'Juventus', publish: false)
end

List.create(name: 'Unpublished list with unpublished items', publish: false).tap do |l|
  l.list_items.create(description: 'AC Milan', publish: false)
  l.list_items.create(description: 'Inter Milan', publish: false)
end
