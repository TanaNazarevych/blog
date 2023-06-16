# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


["social", "political", "fashion"].each do |c|
    Category.find_or_create_by(title: c)
end

require 'faker'
100.times.each_with_index do |index|
    Article.create!(
        title: "#{index}-#{Faker::Book.title}",   
        text: Faker::Lorem.paragraph,
        category:  Category.all.sample
    )
    

end