# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

List.create(name: 'Programming languages').tap do |l|
  ListItem.create(description: 'Ruby', list: l)
  ListItem.create(description: 'Javascript', list: l)
end

List.create(name: 'Common data').tap do |l|
  ListItem.create(description: 'Postgres', list: l)
  ListItem.create(description: 'Redis', list: l)
  ListItem.create(description: 'Elasticsearch', list: l)
  ListItem.create(description: 'Kafka', list: l)
end
