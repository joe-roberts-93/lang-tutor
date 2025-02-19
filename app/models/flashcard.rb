class Flashcard < ApplicationRecord
  belongs_to :submission
  validates :word, presence: true, length: { maximum: 50 }
  validates :definition, presence: true, length: { maximum: 500 }
  validates :example_sentence, presence: true, length: { maximum: 500 }
end
