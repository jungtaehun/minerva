# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "Inserting lecture data.."
File.read("db/seed_data/k_lecture.csv").split("\n").each do |line|
  data = line.strip.split(",")
  puts data.to_s
  Lecture.create(
             id: data[0],
             name: data[1]
  )
end

puts "Inserting professor data.."
File.read("db/seed_data/k_professor.csv").split("\n").each do |line|
  data = line.strip.split(",")
  puts data.to_s
  Professor.create(
      id: data[0],
      name: data[1]
  )
end

puts "Inserting course data.."
File.read("db/seed_data/final.csv").split("\n").each do |line|
  data = line.strip.split(",")
  puts data.to_s
  Course.create!(
      professor_id: data[1],
      lecture_id: data[2],
      dept: data[3],
      year: data[4],
      samester: data[5],
      grade: data[6]
  )
end

