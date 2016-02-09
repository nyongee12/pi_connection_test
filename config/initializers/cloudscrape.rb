CloudscrapeClient.configure do |config|
  config.base_url = "https://app.cloudscrape.com/api/"
  config.api_key = "bf66a983b75985ff1d945a5c0"
  config.account_id = "ce840dcd-6d23-40b7-946c-2fd03669985c"
  config.user_agent_app = "developer.weaved.com"
  config.user_agent_version = "5.0"
  config.timeout = 60000
  config.verbose = true
  config.logger = Rails.logger
end
