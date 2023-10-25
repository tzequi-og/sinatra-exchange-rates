require "sinatra"
require "sinatra/reloader"
require "http"

get("/") do
  @currencies =[]

  api_url = "https://api.exchangerate.host/list?access_key=#{ENV["EXCHANGE_RATE_KEY"]}"
  raw_data = HTTP.get(api_url)
  raw_data_string = raw_data.to_s
  parsed_data = JSON.parse(raw_data_string)

  @currencies_full = parsed_data.fetch("currencies")
  @currencies = @currencies_full.keys

  erb(:homepage)
end

get("/:currency") do
  @currency_from = params.fetch(:currency).to_s

  api_url = "https://api.exchangerate.host/list?access_key=#{ENV["EXCHANGE_RATE_KEY"]}"
  raw_data = HTTP.get(api_url)
  raw_data_string = raw_data.to_s
  parsed_data = JSON.parse(raw_data_string)

  @currencies_full = parsed_data.fetch("currencies")
  @currencies = @currencies_full.keys

  erb(:currency)
end

get("/:currency_from/:currency_to") do
  @currency_from = params.fetch(:currency_from).to_s
  @currency_to = params.fetch(:currency_to).to_s

  api_url = "https://api.exchangerate.host/convert?access_key=#{ENV["EXCHANGE_RATE_KEY"]}&from=#{@currency_from}&to=#{@currency_to}&amount=1"
  raw_data = HTTP.get(api_url)
  raw_data_string = raw_data.to_s
  parsed_data = JSON.parse(raw_data_string)

  @exchange_rate = parsed_data.fetch("result")

  erb(:flexible)
end
