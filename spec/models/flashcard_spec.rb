require 'rails_helper'

RSpec.describe Flashcard, type: :model do
  let (:flashcard) { build(:flashcard) }

  it "is valid with valid attributes" do
    expect(flashcard).to be_valid
  end

  it "is invalid without a submission" do
    flashcard.submission = nil
    expect(flashcard).not_to be_valid
  end

  it "is invalid without a word" do
    flashcard.word = nil
    expect(flashcard).not_to be_valid
  end

  it "is invalid without a definition" do
    flashcard.definition = nil
    expect(flashcard).not_to be_valid
  end

  it "is invalid without an example sentence" do
    flashcard.example_sentence = nil
    expect(flashcard).not_to be_valid
  end

  it "is invalid with a word that is too long" do
    flashcard.word = "a" * 51
    expect(flashcard).not_to be_valid
  end

  it "is invalid with a definition that is too long" do
    flashcard.definition = "a" * 501
    expect(flashcard).not_to be_valid
  end

  it "is invalid with an example sentence that is too long" do
    flashcard.example_sentence = "a" * 501
    expect(flashcard).not_to be_valid
  end
end
