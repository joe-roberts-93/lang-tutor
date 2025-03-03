class SubmissionsController < ApplicationController
  def create
    @submission = Submission.new(submission_params)
    @submission.user_id = @current_user.id
    if @submission.save
      ProcessSubmissionJob.perform_later(@submission.id)
      render json: @submission, status: :created
    else
      render json: @submission.errors, status: :unprocessable_entity
    end
  end

  def show
    @submission = Submission.find(params[:id])
    return render json: { error: "Unauthorized" }, status: :unauthorized unless @submission.user_id == @current_user.id

    render json: @submission
  end

  private

  def submission_params
    params.require(:submission).permit(:text, :language)
  end
end
