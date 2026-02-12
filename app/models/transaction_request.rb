class TransactionRequest
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :amount, :integer
  attribute :currency, :string
  attribute :id, :string

  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :currency, presence: true, length: { is: 3 }
  validates :id, presence: true
end
