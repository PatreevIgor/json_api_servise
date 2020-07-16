require 'rspec'
require 'database_cleaner'

ENV['RACK_ENV'] = 'test'

RSpec.configure do |config|
  # Clean up the database
  config.before(:suite) do
    DatabaseCleaner.clean_with :truncation, { :only => %w{estimations posts users} }
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, :js => true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each, :database) do
    # open transaction
    DatabaseCleaner.start
  end

  config.after(:each, :database) do
    DatabaseCleaner.clean
  end
end
