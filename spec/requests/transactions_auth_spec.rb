require 'rails_helper'

RSpec.describe "Transactions Auth", type: :request do
  describe "GET /transactions/auth/:id" do
    it "returns success when provider returns success" do
      stub_request(:put, "https://provider.example.com/transactions/auth/123")
        .to_return(
          status: 200,
          body: { status: "success" }.to_json,
          headers: { 'Content-Type' => 'application/json' }
        )

      get "/transactions/auth/123"

      expect(response).to have_http_status(:ok)
      expect(response.body).to eq("success")
    end

    it "returns failed when provider returns failed" do
      stub_request(:put, "https://provider.example.com/transactions/auth/456")
        .to_return(
          status: 200,
          body: { status: "failed" }.to_json,
          headers: { 'Content-Type' => 'application/json' }
        )

      get "/transactions/auth/456"

      expect(response).to have_http_status(:ok)
      expect(response.body).to eq("failed")
    end

    it "returns failed when provider raises error" do
      stub_request(:put, "https://provider.example.com/transactions/auth/789")
        .to_return(status: 500)

      get "/transactions/auth/789"

      expect(response).to have_http_status(:bad_gateway)
      expect(response.body).to eq("failed")
    end
  end
end
