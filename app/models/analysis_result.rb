class AnalysisResult
  # AnalysisResult is NOT a model in my database
  # It is a simple object for passing data from the analysis service
  attr_reader :feedback, :flashcards, :questions

  def initialize(data)
    @feedback = data[:feedback]
    @flashcards = data[:flashcards] || []
    @questions = data[:questions] || []
  end
end
