module LlmClients
  class LLMClient
    def analyze(text, language)
      raise NotImplementedError, "Subclasses must implement #analyze"
    end
  end
end
