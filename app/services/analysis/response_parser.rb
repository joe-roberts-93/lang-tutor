  module Analysis
    class ResponseParser
      def initialize(response)
        puts response
        @response = clean_response(response)
        validate_keys(@response)
      end

      def parse
        {
          analysis: @response["analysis"],
          flashcards: Flashcards::FlashcardService.new(@response["flashcards"]).build,
          questions: Questions::GrammaticalQuestionsService.new(@response["grammatical_questions"]).build
        }
      end

      private

      def clean_response(response)
        return response if response.is_a?(Hash)
        response = remove_markdown(response) if response.is_a?(String)
        begin
          JSON.parse(response)
        rescue JSON::ParserError => e
          raise "Invalid JSON response: #{e.message}"
        end
      end

      def remove_markdown(text)
        text.gsub(/\A```json\s*|\s*```\z/, "")
      end

      def validate_keys(response)
        required_keys = %w[analysis flashcards grammatical_questions]
        missing_keys = required_keys - response.keys
        raise "Missing keys: #{missing_keys.join(", ")}" unless missing_keys.empty?
      end
    end
  end
