require 'rails_helper'

RSpec.describe "Dares", type: :request do
  let!(:user) { create(:user, email: 'test@example.com', password: 'password') }
  let!(:game) { create(:game, user_id: user.id) }
  before do
    sign_in user
  end

  let(:valid_attributes) do
    { template: "Sample template", user_id: user.id }
  end

  describe "GET /index" do
    it "returns a success response" do
      Dare.create!(valid_attributes)
      get dares_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /create" do
    it "creates a new Dare" do
      expect do
        post dares_path, params: { dare: valid_attributes }
      end.to change(Dare, :count).by(1)
    end
  end
  # add edit, update actions, edit view
  xdescribe "PATCH /update" do
    it "updates an existing Dare" do
      dare = Dare.create!(valid_attributes)
      patch dare_path(dare), params: { dare: { template: "Updated dare" } }
      dare.reload
      expect(dare.template).to eq("Updated dare")
    end
  end

  describe "DELETE /destroy" do
    it "destroys a Dare" do
      dare = Dare.create!(valid_attributes)
      expect do
        delete dare_path(dare)
      end.to change(Dare, :count).by(-1)
    end
  end
end
