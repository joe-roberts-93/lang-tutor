require 'rails_helper'
include JsonWebToken

RSpec.describe "Flashcards", type: :request do

  let(:user) { create(:user) }
  let(:token) { jwt_encode(user_id: user.id) }
  let(:headers) { { 'Authorization' => token } }
  let!(:flashcards) { create_list(:flashcard, 10, submission: create(:submission, user: user)) }

  

  describe "GET /index" do
    it "returns http success" do
      get "/flashcards", headers: headers
      expect(response).to have_http_status(:success)
    end

    it "returns all flashcards" do
      get "/flashcards", headers: headers
      expect(json.size).to eq(10)
    end

    context "when the user doesn't own the flashcards" do
      let(:other_user) { create(:user) }
      let(:other_flashcards) { create_list(:flashcard, 5, submission: create(:submission, user: other_user)) }

      it "returns only the user's flashcards" do
        get "/flashcards", headers: headers
        expect(json.size).to eq(10)
      end
    end

    context "when the user is not authenticated" do
      it "returns unauthorized" do
        get "/flashcards"
        expect(response).to have_http_status(:unauthorized)
        expect(json["errors"]).to eq("Nil JSON web token")
      end
    end
  end

  describe "GET /show" do
    context "when the flashcard belongs to the user" do
      it "returns http success" do
        get "/flashcards/#{flashcards.first.id}", headers: headers
        expect(response).to have_http_status(:success)
      end

      it "returns the flashcard" do
        get "/flashcards/#{flashcards.first.id}", headers: headers
        expect(json["id"]).to eq(flashcards.first.id)
      end
    end

    context "when the flashcard doesn't belong to the user" do
      let(:other_user) { create(:user) }
      let(:other_flashcard) { create(:flashcard, submission: create(:submission, user: other_user)) }

      it "returns forbidden" do
        get "/flashcards/#{other_flashcard.id}", headers: headers
        expect(response).to have_http_status(:forbidden)
        expect(json["errors"]).to eq("Forbidden")
      end
    end
  end

  def json
    JSON.parse(response.body)
  end
end
