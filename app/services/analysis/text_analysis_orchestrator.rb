module Analysis
  class TextAnalysisOrchestrator
    def initialize(text, language)
      @text = text
      @language = language
    end

    def analyze
      response = TextAnalysisService.new(@text, @language).analyze
      ResponseParser.new(response).parse
    end
  end
end
