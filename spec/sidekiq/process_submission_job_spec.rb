require 'rails_helper'
require 'sidekiq/testing'

RSpec.describe ProcessSubmissionJob, type: :job do
  let(:user) { create(:user) }
  let(:submission) { create(:submission, user: user, text: "Test text", language: "en") }
  let(:logger) { instance_double("Logger") }

  def mock_analysis_result
    AnalysisResult.new(
      feedback: "Test feedback",
      flashcards: [
        {
          "word" => "Test word",
          "definition" => "Test definition",
          "example_sentence" => "Test example"
        }
      ],
      questions: [
        {
          "question" => "Test question"
        }
      ]
    )
  end

  describe "#perform" do
    before do
      allow_any_instance_of(Analysis::TextAnalysisOrchestrator).to receive(:process_submission).and_return(mock_analysis_result)
    end

    it "processes a submission and updates submission feedback" do
      ProcessSubmissionJob.new.perform(submission.id)
      submission.reload
      expect(submission.feedback).to eq("Test feedback")
    end

    it "processes a submission and creates flashcards" do
      expect { ProcessSubmissionJob.new.perform(submission.id) }.to change { Flashcard.count }.by(1)
    end


   context "when submission is not found" do
      it "logs an error" do
        expect(Rails.logger).to receive(:error).with("Submission not found: 999")
        ProcessSubmissionJob.new.perform(999)
      end
    end

    context "when flashcard is invalid" do
      before do
        allow_any_instance_of(Analysis::TextAnalysisOrchestrator).to receive(:process_submission).and_return(
          AnalysisResult.new(
            feedback: "Test feedback",
            flashcards: [ { "word" => "", "definition" => "", "example_sentence" => "" } ], # Invalid data
            questions: []
          )
        )
      end

      it "logs an error" do
        expect(Rails.logger).to receive(:error).with(/Failed to create flashcard for submission #{submission.id}:/)
        ProcessSubmissionJob.new.perform(submission.id)
      end

      it "does not create flashcards" do
        expect { ProcessSubmissionJob.new.perform(submission.id) }.not_to change { Flashcard.count }
      end
    end
  end
end
