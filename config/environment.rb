# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Sipproxy::Application.initialize!

AUTH_DB_ENGINE = 'dbtext'
ALIAS_DB_ENGINE = 'dbtext'

if (Rails.env.production?)
  DBTEXT_SUBSCRIBER_FILE = '/opt/kamailio-3.1/etc/kamailio/db_text/subscriber'
  DBTEXT_DBALIASES_FILE = '/opt/kamailio-3.1/etc/kamailio/db_text/dbaliases'
elsif (Rails.env.test?)
  DBTEXT_SUBSCRIBER_FILE = '/tmp/subscriber.test'
  DBTEXT_DBALIASES_FILE = '/tmp/dbaliases.test'
else
  DBTEXT_SUBSCRIBER_FILE = '/tmp/subscriber'
  DBTEXT_DBALIASES_FILE = '/tmp/dbaliases'
end
