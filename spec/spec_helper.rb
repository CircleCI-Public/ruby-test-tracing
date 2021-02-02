require "honeycomb-beeline"

# Do not commit an actual key here, this is just to make running this easier, and should load from env vars / etc
Honeycomb.configure do |config|
  config.write_key = "WRITE_KEY_HERE"
  config.dataset = "dataset"
  config.service_name = "rspec-tests"

  # Uncomment the following to log the tracing locally
  # config.client = Libhoney::LogClient.new
end

RSpec.shared_context "tracing", :shared_context => :metadata do
  # Instrument each individual example as a span
  around :each do |example|
    Honeycomb.start_span(name: example.description) do
      example.run
    end
  end

  # Instrument each example group as a span
  before :all do |group|
    @span = Honeycomb.start_span(name: group.class.name)
  end
  after :all do
    @span.send
  end
end

RSpec.configure do |config|
  # Instrument the entire test suite with a single root span
  config.before :suite do
    $spec_span = Honeycomb.start_span(name: "rspec tests")
  end
  config.after :suite do
    $spec_span.send
  end

  # Include the tracing context in every test, so they need minimal modification
  config.include_context "tracing"

  # Standard boring RSpec setup
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
  config.shared_context_metadata_behavior = :apply_to_host_groups
end
