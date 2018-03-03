class Professor < ApplicationRecord
  has_many :courses
  has_many :lectures, through: :courses
end
