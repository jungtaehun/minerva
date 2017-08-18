# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "Inserting lecture data.."
File.read("db/seed_data/k_lecture.CSV").split("\n").each do |line|
  data = line.strip.split(",")
  Lecture.create(
             id: data[0],
             name: data[1]
  )
end

puts "Inserting professor data.."
File.read("db/seed_data/k_professor.CSV").split("\n").each do |line|
  data = line.strip.split(",")
  Professor.create(
      id: data[0],
      name: data[1]
  )
end

puts "Inserting course data.."
File.read("db/seed_data/final.csv").split("\n").each do |line|
  data = line.strip.split(",")
  Course.create(
      id: data[0],
      professor_id: data[1],
      lecture_id: data[2]
  )
end

