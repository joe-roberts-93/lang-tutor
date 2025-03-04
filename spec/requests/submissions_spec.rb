require 'rails_helper'

RSpec.describe "Submissions", type: :request do
  let(:user) { create(:user) }
  let(:submission) { create(:submission, user: user) }
  let!(:submissions) { create_list(:submission, 10, user: user) }
  let(:other_user) { create(:user) }
  let!(:other_user_submission) { create(:submission, user: other_user) }
  let(:token) { jwt_encode(user_id: user.id) }
  let(:headers) { { 'Authorization' => token } }
  describe "GET /index" do
    context "when user is authenticated" do
      it "returns all of the user's submissions" do
        get "/submissions", headers: headers
        puts "User ID: #{user.id}"
        for submission in submissions
          puts submission.user.id
        end
        puts "json: #{json}"
        expect(response).to have_http_status(:success)
        expect(json.size).to eq(10)
      end
      it "does not return other user's submissions" do
        get "/submissions", headers: headers
        expect(json.map { |submission| submission["id"] }).not_to include(other_user_submission.id)
      end
    end
  end

  describe "POST /create" do
    context "when user is not authenticated" do
      it "returns unauthorized" do
        post "/submissions"
        expect(response).to have_http_status(:unauthorized)
      end
    end
    context "when user is authenticated" do
      submission_params = { text: "This is a test submission", language: "English" }
      it "creates a new submission" do
        post "/submissions", params: { submission: submission_params }, headers: headers
        expect(response).to have_http_status(:created)
      end
      it "returns the new submission" do
        post "/submissions", params: { submission: submission_params }, headers: headers
        expect(json["text"]).to eq("This is a test submission")
      end
    end
  end

  describe "GET /show" do
    context "when the submission belongs to the user" do
      it "returns the submission" do
        get "/submissions/#{submission.id}", headers: headers
        expect(response).to have_http_status(:success)
        expect(json["id"]).to eq(submission.id)
      end
    end
    context "when the submission does not belong to the user" do
      it "returns forbidden" do
        get "/submissions/#{other_user_submission.id}", headers: headers
        expect(response).to have_http_status(:forbidden)
      end
    end
  end
end
