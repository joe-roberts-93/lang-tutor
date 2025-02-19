require 'rails_helper'

RSpec.describe User, type: :model do
  let (:user) { build(:user) }

  it "is valid with valid attributes" do
    expect(user).to be_valid
  end

  it "is invalid without an email" do
    user.email = nil
    expect(user).not_to be_valid
  end

  it "is invalid with an empty email" do
    user.email = ""
    expect(user).not_to be_valid
  end

  it "is invalid without a password digest" do
    user.password_digest = nil
    expect(user).not_to be_valid
  end

  it "is invalid with an empty password digest" do
    user.password_digest = ""
    expect(user).not_to be_valid
  end

  it "is invalid with an email that is not formatted correctly" do
    invalid_emails = [ "example.com", "user@com", "user.com@", "user@.com", "@example.com" ]
    invalid_emails.each do |email|
      user.email = email
      expect(user).not_to be_valid, "#{email} should be invalid"
    end
  end

  it "is invalid with a duplicate email" do
    user.save
    user2 = build(:user)
    user2.email = user.email
    expect(user2).not_to be_valid
  end

  it "is invalid with a duplicate email (case insensitive)" do
    user.save
    user2 = build(:user)
    user2.email = user.email.upcase
    expect(user2).not_to be_valid
  end

  it "downcases the email before saving" do
    upcased_email = "TEST@EMAIL.COM"
    user.email = upcased_email
    user.save
    expect(user.email).to eq(upcased_email.downcase)
  end

  it "destroys associated submissions when deleted" do
    user.save
    submission = create(:submission, user: user)
    expect { user.destroy }.to change { Submission.count }.by(-1)
  end
end
