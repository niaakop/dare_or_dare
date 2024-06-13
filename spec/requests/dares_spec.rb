require 'rails_helper'

RSpec.describe "Dares", type: :request do
  before do
    @user = User.create!(email: 'test@example.com', password: 'password')
    sign_in @user
  end

  let(:valid_attributes) {
    { text: "Sample dare", template: "Sample template", user_id: @user.id }
  }

  describe "GET /index" do
    it "returns a success response" do
      Dare.create!(valid_attributes)
      get dares_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns a success response" do
      dare = Dare.create!(valid_attributes)
      get dare_path(dare)
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /create" do
    it "creates a new Dare" do
      expect {
        post dares_path, params: { dare: valid_attributes }
      }.to change(Dare, :count).by(1)
    end
  end

  describe "PATCH /update" do
    it "updates an existing Dare" do
      dare = Dare.create!(valid_attributes)
      patch dare_path(dare), params: { dare: { text: "Updated dare" } }
      dare.reload
      expect(dare.text).to eq("Updated dare")
    end
  end

  describe "DELETE /destroy" do
    it "destroys a Dare" do
      dare = Dare.create!(valid_attributes)
      expect {
        delete dare_path(dare)
      }.to change(Dare, :count).by(-1)
    end
  end
end
