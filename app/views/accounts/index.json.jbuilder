json.array!(@accounts) do |account|
  json.extract! account, :id, :customer_id, :number, :balance
  json.url account_url(account, format: :json)
end
