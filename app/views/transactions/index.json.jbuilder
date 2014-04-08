json.array!(@transactions) do |transaction|
  json.extract! transaction, :id, :from_account_id, :to_account_id, :amount, :timestamp
  json.url transaction_url(transaction, format: :json)
end
