require 'rails_helper'

RSpec.describe Analysis::TextAnalysisService do
  let (:text) { "Ceci est un exemple de texte." }
  let (:language) { "French" }
  let (:mock_response) {
    {
      "analysis" => "Test analysis",
      "flashcards" => [],
      "grammatical_questions" => []
    }
  }
  let (:gemini_client) { double("LlmClients::GeminiClient") }

  before do
    allow(gemini_client).to receive(:analyze).and_return(mock_response)
  end

  it "returns analysis" do
    result = described_class.new(text, language, llm: gemini_client).analyze
    expect(result).to eq(mock_response)
  end

  context "when LLM client raises an error" do
    before do
      allow(gemini_client).to receive(:analyze).and_raise(Net::ReadTimeout)
    end

    it "raises an error" do
      service = described_class.new(text, language, llm: gemini_client)
      expect { service.analyze }.to raise_error(StandardError, "Text analysis failed due to timeout")
    end
  end

  describe "#analyze" do
    before do
      allow(gemini_client).to receive(:analyze).and_return(mock_response)
    end

    context "when text is empty" do
      let(:text) { "" }

      it "raises an error" do
        service = described_class.new(text, language, llm: gemini_client)
        expect { service.analyze }.to raise_error(ArgumentError, "Text cannot be empty")
      end
    end

    context "when language is nil" do
      let(:language) { nil }

      it "raises an error" do
        service = described_class.new(text, language, llm: gemini_client)
        expect { service.analyze }.to raise_error(ArgumentError, "Language is required")
      end
    end
  end
end
