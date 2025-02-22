require "net/http"
module Analysis
  class TextAnalysisService
    def initialize(text, language, llm: LlmClients::GeminiClient.new(ENV.fetch("GOOGLE_GEMINI_API_KEY")))
      @text = text
      @language = language
      @llm = llm
    end

    def analyze
      response = @llm.analyze(@text, @language)
    end
  end
end
