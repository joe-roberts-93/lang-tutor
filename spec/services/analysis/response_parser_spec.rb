require "rails_helper"

RSpec.describe Analysis::ResponseParser do
  let(:response) do
    {
      "feedback" => "Test feedback",
      "flashcards" => [],
      "grammatical_questions" => []
    }
  end

  subject(:parsed_response) { described_class.new(response).parse }

  it "returns parsed response" do
    expect(subject).to include(:feedback, :flashcards, :questions)
    expect(subject[:feedback]).to eq("Test feedback")
  end

  it "returns flashcards" do
    expect(subject[:flashcards]).to eq([])
  end

  it "returns grammatical questions" do
    expect(subject[:questions]).to eq([])
  end

  it "raises error if response is not a hash" do
    expect { described_class.new("invalid response").parse }.to raise_error("Invalid JSON response: unexpected character: 'invalid response'")
  end

  it "removes markdown from response" do
    response = "```json\n{\"feedback\":\"Test feedback\",\"flashcards\":[],\"grammatical_questions\":[]}\n```"
    parsed_response = described_class.new(response).parse
    expect(parsed_response).to include(:feedback, :flashcards, :questions)
    expect(parsed_response[:feedback]).to eq("Test feedback")
  end

  it "raises error if required keys are missing" do
    response = { "feedback" => "Test feedback" }
    expect { described_class.new(response).parse }.to raise_error("Missing keys: flashcards, grammatical_questions")
  end
end
