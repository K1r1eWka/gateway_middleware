class TransactionsController < ApplicationController
  def auth
    provider_response = ProviderClient.auth_transaction(params[:id])

    if provider_response[:status] == "success"
      render plain: "success"
    else
      render plain: "failed"
    end
  rescue ProviderClient::Error
    render plain: "failed", status: :bad_gateway
  end
end
