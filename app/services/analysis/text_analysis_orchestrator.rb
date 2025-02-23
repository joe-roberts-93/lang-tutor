module Analysis
  class TextAnalysisOrchestrator
    def initialize(text, language)
      @text = text
      @language = language
    end

    def process_submission
      response = TextAnalysisService.new(@text, @language).analyze
      parsed_response = ResponseParser.new(response).parse
      AnalysisResult.new(parsed_response)
    end
  end
end
