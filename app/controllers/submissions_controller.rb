class SubmissionsController < ApplicationController
  def create
    @submission = Submission.new(submission_params)
    if @submission.save
      ProcessSubmissionJob.perform_later(@submission.id)
      render json: @submission, status: :created
    else
      render json: @submission.errors, status: :unprocessable_entity
    end
  end

  def show
    @submission = Submission.find(params[:id])
    analysis_result = TextAnalysisOrchestrator.new(@submission.text, @submission.language).process_submission
    analysis_result.flashcards.each do |flashcard|
      Flashcard.create(flashcard.merge(submission_id: @submission.id))
    end
  end

  private

  def submission_params
    params.require(:submission).permit(:text, :user_id, :language)
  end
end
