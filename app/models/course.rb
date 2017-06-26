class Course < ApplicationRecord
  has_many :evaluations
  has_many :favorites
  has_many :users, through: :favorites
  belongs_to :lecture
  belongs_to :professor
end
