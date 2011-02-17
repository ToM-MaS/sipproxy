# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Sipproxy::Application.initialize!

AUTH_DB_ENGINE = 'dbtext'
ALIAS_DB_ENGINE = 'dbtext'

if (Rails.env.production?)
  DBTEXT_SUBSCRIBER_FILE = '/tmp/subscriber'
  DBTEXT_DBALIASES_FILE = '/tmp/dbaliases'
elsif (Rails.env.test?)
  DBTEXT_SUBSCRIBER_FILE = '/tmp/subscriber.test'
  DBTEXT_DBALIASES_FILE = '/tmp/dbaliases.test'
else
  DBTEXT_SUBSCRIBER_FILE = '/tmp/subscriber'
  DBTEXT_DBALIASES_FILE = '/tmp/dbaliases'
end
