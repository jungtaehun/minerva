class Lecture < ApplicationRecord
  has_many :courses
  has_many :professors, through: :courses
end
