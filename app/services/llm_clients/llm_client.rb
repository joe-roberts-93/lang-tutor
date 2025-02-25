module LlmClients
  class LlmClient
    def analyze(text, language)
      raise NotImplementedError, "Subclasses must implement #analyze"
    end
  end
end
