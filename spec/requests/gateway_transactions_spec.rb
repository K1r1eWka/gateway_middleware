require 'rails_helper'

RSpec.describe "Gateway Transactions", type: :request do
  describe "POST /gateway/transactions" do
    context "when params are valid" do
      it "returns redirect_url when provider init succeeds" do
        stub_request(:post, "https://provider.example.com/transactions/init")
          .to_return(
            status: 200,
            body: { transaction_id: "123", status: "pending" }.to_json,
            headers: { "Content-Type" => "application/json" }
          )

        post "/gateway/transactions", params: {
          transaction: {
            amount: 1000,
            currency: "EUR",
            id: "abc"
          }
        }

        expect(response).to have_http_status(:ok)

        json = JSON.parse(response.body)

        expect(json["redirect_url"]).to include("/transactions/auth/123")
      end
    end

    context "when params are invalid" do
      it "returns 422 and validation errors" do
        post "/gateway/transactions", params: {
          transaction: {
            amount: -100,
            currency: "EU",
            id: nil
          }
        }

        expect(response).to have_http_status(:unprocessable_entity)

        json = JSON.parse(response.body)

        expect(json["errors"]).to be_present
      end
    end
  end
end
