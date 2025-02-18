class CreateFlashcards < ActiveRecord::Migration[7.2]
  def change
    create_table :flashcards do |t|
      t.string :word
      t.text :definition
      t.string :example_sentence
      t.references :submission, null: false, foreign_key: true

      t.timestamps
    end
  end
end
