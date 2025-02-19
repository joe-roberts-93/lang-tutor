require 'rails_helper'

RSpec.describe Submission, type: :model do
  let(:submission) { build(:submission) }

  it "is valid with valid attributes" do
    expect(submission).to be_valid
  end

  it "is invalid without text" do
    submission.text = nil
    expect(submission).not_to be_valid
  end

  it "is invalid without a user" do
    submission.user = nil
    expect(submission).not_to be_valid
  end
end
