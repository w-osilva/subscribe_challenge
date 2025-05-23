# frozen_string_literal: true

require_relative '../environment'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'
end
