class FlashcardsController < ApplicationController
  def index
    @flashcards = @current_user.flashcards
    render json: @flashcards
  end

  def show
    @flashcard = @current_user.flashcards.find_by(id: params[:id])
    return render json: { error: "Unauthorized" }, status: :unauthorized unless @flashcard
    render json: @flashcard
  end
end
