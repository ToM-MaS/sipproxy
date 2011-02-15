# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Sipproxy::Application.initialize!

AUTH_DB_ENGINE = 'dbtext'
DBTEXT_SUBSCRIBER_FILE = '/tmp/subscriber'
