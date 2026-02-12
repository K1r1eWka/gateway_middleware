class Gateway::TransactionsController < ApplicationController
  protect_from_forgery with: :null_session

  def create
    # data validation
    request = TransactionRequest.new(transaction_params)
    unless request.valid?
      return render json: { errors: request.errors.full_messages }, status: :unprocessable_entity
    end


    provider_response = ProviderClient.init_transaction(transaction_params)

    # auth_transaction_url - routre(rails helper)
    redirect_url = auth_transaction_url(provider_response[:transaction_id])

    render json: { redirect_url: redirect_url }
  rescue ProviderClient::Error => e
    render json: { error: e.message }, status: :bad_gateway
  end


  private

  def transaction_params
    params.require(:transaction).permit(:amount, :currency, :id)
  end
end
