class ProcessSubmissionJob < ApplicationJob
  queue_as :default

  def perform(submission_id)
    submission = Submission.find_by(id: submission_id)
    unless submission
      Rails.logger.error "Submission not found: #{submission_id}"
      return
    end
    analysis_result = Analysis::TextAnalysisOrchestrator.new(submission.text, submission.language).process_submission
    analysis_result.flashcards.each do |flashcard_data|
      save_flashcard(submission, flashcard_data)
    end
    update_submission_feedback(submission, analysis_result.feedback)
  end

  private

  def save_flashcard(submission, flashcard_data)
    flashcard = Flashcard.new(flashcard_data.merge(submission_id: submission.id))
    unless flashcard.save
      Rails.logger.error "Failed to create flashcard for submission #{submission.id}: #{flashcard.errors.full_messages.join(", ")}"
    end
  end

  def update_submission_feedback(submission, feedback)
    unless submission.update(feedback: feedback)
      Rails.logger.error "Failed to update submission #{submission.id}: #{submission.errors.full_messages.join(", ")}"
    end
  end
end
