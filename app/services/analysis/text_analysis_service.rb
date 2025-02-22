require "net/http"
module Analysis
  class TextAnalysisService
    def initialize(text, language, llm: LlmClients::GeminiClient.new(ENV.fetch("GOOGLE_GEMINI_API_KEY")))
      @text = text
      @language = language
      @llm = llm
    end

    def analyze
      raise ArgumentError, "Text cannot be empty" if @text.nil? || @text.strip.empty?
      raise ArgumentError, "Language is required" if @language.nil? || @language.strip.empty?
      response = @llm.analyze(@text, @language)
    rescue Net::ReadTimeout
      raise StandardError, "Text analysis failed due to timeout"
    end
  end
end
