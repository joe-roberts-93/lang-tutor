# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


user = User.create(email: 'jane@email.com', password: 'password')
user2 = User.create(email: 'john@email.com', password: 'password')
submission = Submission.create(user: user, text: 'This is a test submission', language: 'English')
submission2 = Submission.create(user: user2, text: 'Ceci est un exemple de texte.', language: 'French')
flashcard = Flashcard.create(
  submission: submission,
  word: 'test',
  definition: 'a procedure intended to establish the quality, performance, or reliability of something.',
  example_sentence: 'The system has been tested for bugs.'
)
flashcard2 = Flashcard.create(
  submission: submission2,
  word: 'exemple',
  definition: 'une chose choisie pour montrer ce qu\'est une chose ou un groupe de choses.',
  example_sentence: 'Ceci est un exemple de texte.'
)

puts 'Seeds created successfully'
