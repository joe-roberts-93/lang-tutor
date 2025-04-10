  require "rails_helper"

  RSpec.describe Analysis::TextAnalysisOrchestrator do
    let(:text) { "Ceci est un exemple de texte." }
    let(:language) { "French" }
    let(:mock_response) do
      {
        "feedback" => "Test analysis",
        "flashcards" => [],
        "grammatical_questions" => []
      }
    end
    let(:mock_parsed_response) do
      {
        feedback: "Test analysis",
        flashcards: [],
        questions: []
      }
    end
    let(:mock_text_analysis_service) { double("Analysis::TextAnalysisService", analyze: mock_response) }

    before do
      # This is a stub. It will return the same response every time. Isolates testing of the TextAnalysisOrchestrator class.
      allow(Analysis::TextAnalysisService).to receive(:new).and_return(mock_text_analysis_service)
      allow_any_instance_of(Analysis::ResponseParser).to receive(:parse).and_return(mock_parsed_response)
    end

    it "returns analysis result object" do
      analysis_result = described_class.new(text, language).process_submission
      expect(analysis_result).to be_an_instance_of(AnalysisResult)
    end

    it "returns analysis result with feedback, flashcards, and questions attributes" do
      analysis_result = described_class.new(text, language).process_submission
      expect(analysis_result.feedback).to eq("Test analysis")
      expect(analysis_result.flashcards).to eq([])
      expect(analysis_result.questions).to eq([])
    end
  end
