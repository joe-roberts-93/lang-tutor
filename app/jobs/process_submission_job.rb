class ProcessSubmissionJob < ApplicationJob
  queue_as :default

  def perform(submission_id)
    submission = Submission.find(submission_id)
    analysis_result = Analysis::TextAnalysisOrchestrator.new(submission.text, submission.language).process_submission
    analysis_result.flashcards.each do |flashcard|
      Flashcard.create(flashcard.merge(submission_id: submission.id))
    end
  end
end
