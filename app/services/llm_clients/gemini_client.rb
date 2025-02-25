require_relative "llm_client"
require_relative "prompt_builder"
module LlmClients
  class GeminiClient < LlmClient
    def initialize(api_key)
      @llm = Langchain::LLM::GoogleGemini.new(api_key: api_key)
    end

    def analyze(text, language)
      prompt = PromptBuilder.build_analysis_prompt(text, language)
      response = @llm.chat(messages: [ { role: "user", parts: [ { text: prompt } ] } ])
      response.chat_completion
    end
  end
end
