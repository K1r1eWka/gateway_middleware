# README
A Ruby on Rails middleware handling transaction flow between Gateway and Provider systems

# Middleware App – Gateway / Provider

## Ruby version
3.2.4

## System dependencies
- Rails 7.1
- Bundler
- Faraday (HTTP client)
- Webmock (for tests)

## Configuration
- No special configuration required.
- Provider URL is set in `ProviderClient::BASE_URL`.

## External services
- Provider API – handled via `ProviderClient` service
  - `POST /transactions/init` to start a transaction
  - `PUT /transactions/auth/:id` to authorize a transaction

## How to run the test suite
```bash
bundle install
bundle exec rspec
``` 

## Identify security issues
- Input validation is required to prevent invalid or malicious data.
- CSRF protection is disabled for API requests (`null_session`), consider other safeguards.
- Redirect URL should be secure to prevent transaction hijacking.
- Users should be authenticated (e.g., via JWT) before initiating payments to prevent unauthorized transactions. 
