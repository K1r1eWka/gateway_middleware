class ProviderClient
  class Error < StandardError; end

  BASE_URL = "https://provider.example.com"

  # Call the Provider API to initiate a transaction
  # Provider API returns to us JSON { "transaction_id": "123", "status": "pending" }
  def self.init_transaction(payload)
    response = Faraday.post(
      "#{BASE_URL}/transactions/init",
      payload.to_json,
      headers
    )

    parse_response(response) # { "transaction_id": "123", "status": "pending" }
  end


  # TODO may by id parameter renanme to transaction_id for better readability
  # PUT method becouse we need to update(change) transaction status
  def self.auth_transaction(transaction_id)
    response = Faraday.put(
      "#{BASE_URL}/transactions/auth/#{transaction_id}",
      nil,
      headers
    )

    parse_response(response)
  end

  private

  def self.parse_response(response)
    raise Error, "Provider error" unless response.success?

    JSON.parse(response.body, symbolize_names: true)
  end

  def self.headers
    { "Content-Type" => "application/json" }
  end
end
