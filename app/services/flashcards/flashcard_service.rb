module Flashcards
  class FlashcardService
    def initialize(flashcard_data)
      @flashcard_data = flashcard_data
      puts @flashcard_data
    end
    def build
      @flashcard_data.map do |flashcard|
        {
          word: flashcard["word"],
          definition: flashcard["definition"],
          synonyms: flashcard["synonyms"].split(", ")
        }
      end
    end
  end
end
