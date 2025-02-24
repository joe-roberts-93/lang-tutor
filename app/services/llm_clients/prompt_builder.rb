module LlmClients
  module PromptBuilder
    def self.build_analysis_prompt(text, language)
      <<~PROMPT
        Analyze the following #{language} text:

        #{text}

        Return a JSON object with the structure:
        {
          "feedback": "<feedback>",
          "flashcards": "<flashcards>",
          "grammatical_questions": "<grammatical_questions>"
        }
        The feedback should be text containing overall summary of corrections and feedback for the language learner based on the text.
        The feedback text need not describe the text or provide feedback on the content, just provide actionable linguistic feedback appropriate to the perceived level of the learner.
        The feedback text doesn't need to reassure the learner, but should be constructive and actionable.
        If you make a substition suggestion, explain why the original word or phrase was incorrect.
        The flashcards should be an array of fewer than 25 flashcards, each with the structure:
        {
          "word": "<word>",
          "definition": "<definition>",
          "example": "<example>"
        }
        The definition should be a simple definition of the word in #{language} in fewer than 200 characters.
        The example should be simple sentence or phrase containing the word, pitched at the user's level. The sentence or phrase should be fewer than 150 characters.
        Grammatical questions should be an array of 5 objects.
        Each of these objects should have the structure
          {
            "question": "<question>",
            "answers": ["<answer1>", "<answer2>", "<answer3>", "<answer4>"],
            "correct_answer_index": <index>
          }
        The questions should be based on misunderstandings apparent in the text or based on the feedback given.
        There should be 4 potential answers, of which only one should be correct.
        - If #{language} is gendered, include the indefinite article before nouns.
        - If #{language} is tonal, include tone marks.
        - If #{language} is logographic, include pronunciation.
      PROMPT
    end
  end
end
