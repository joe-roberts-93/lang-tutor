class AnalysisResult
  # AnalysisResult is NOT a model in my database
  # It is a simple object for passing data from the analysis service
  attr_reader :analysis, :flashcards, :questions

  def initialize(data)
    @analysis = data[:analysis]
    @flashcards = data[:flashcards] || []
    @questions = data[:questions] || []
  end
end
