class User < ApplicationRecord
  has_secure_password
  has_many :submissions, dependent: :destroy
  has_many :flashcards, through: :submissions
end
