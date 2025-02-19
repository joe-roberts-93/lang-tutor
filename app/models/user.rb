class User < ApplicationRecord
  has_secure_password
  before_validation :downcase_email
  has_many :submissions, dependent: :destroy
  has_many :flashcards, through: :submissions

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
  validates :password_digest, presence: true

  private

  def downcase_email
    self.email = email.downcase.strip if email.present?
  end
end
