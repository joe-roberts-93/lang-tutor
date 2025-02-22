require "rails_helper"

RSpec.describe Analysis::TextAnalysisOrchestrator do
  let(:text) { "Ceci est un exemple de texte." }
  let(:language) { "French" }
  let(:mock_response) do
    {
      "analysis" => "Test analysis",
      "flashcards" => [],
      "grammatical_questions" => []
    }
  end
  let(:mock_parsed_response) do
    {
      analysis: "Test analysis",
      flashcards: [],
      questions: []
    }
  end

  before do
    # This is a stub. It will return the same response every time. Isolates testing of the TextAnalysisOrchestrator class.
    allow_any_instance_of(Analysis::TextAnalysisService).to receive(:analyze).and_return(mock_response)
    allow_any_instance_of(Analysis::ResponseParser).to receive(:parse).and_return(mock_parsed_response)
  end

  it "returns parsed response" do
    result = described_class.new(text, language).analyze
    expect(result).to include(:analysis, :flashcards, :questions)
    expect(result[:analysis]).to eq("Test analysis")
  end
end
