module Questions
  class GrammaticalQuestionsService
    def initialize(grammatical_questions)
      @grammatical_questions = grammatical_questions
    end

    def build
      @grammatical_questions.map do |question|
        {
          question: question["question"],
          answers: question["answers"],
          correct_answer_index: question["correct_answer_index"]
        }
      end
    end
  end
end
