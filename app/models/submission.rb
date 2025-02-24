class Submission < ApplicationRecord
  belongs_to :user
  validates :text, presence: true
  has_many :flashcards
end
