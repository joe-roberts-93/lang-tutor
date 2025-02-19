FactoryBot.define do
  factory :flashcard do
    word { "MyString" }
    definition { "MyText" }
    example_sentence { "MyString" }
    submission
  end
end
