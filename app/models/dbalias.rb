# == Schema Information
# Schema version: 20110217085508
#
# Table name: dbaliases
#
#  id             :integer         not null, primary key
#  alias_username :string(255)
#  alias_domain   :string(255)
#  username       :string(255)
#  domain         :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#  subscriber_id  :integer
#

class Dbalias < ActiveRecord::Base
  validates_presence_of :alias_username
  validates_presence_of :username
  validates_presence_of :domain
  validates_presence_of :alias_domain
  validates_uniqueness_of :alias_username, :scope => [:alias_domain, :username, :domain]
  validates_uniqueness_of :alias_domain, :case_sensitive => false, :scope => [:domain, :username, :alias_username]
  
  after_save :generate_alias_db
  after_destroy :generate_alias_db

  belongs_to :subscriber, :validate => true
  
  validate :username_and_domain_must_exist_in_subscriber
  validate :alias_username_and_alias_domain_must_not_exist_in_subscriber
  
  private
  
  def username_and_domain_must_exist_in_subscriber
    subscriber = Subscriber.first(:conditions => { :username => self.username, :domain => self.domain})
    if (! subscriber)
      errors.add( :username, "not found" )
      errors.add( :domain, "not found" )
    else
      self.subscriber_id = subscriber.id
    end
  end
  
  def alias_username_and_alias_domain_must_not_exist_in_subscriber
    subscriber = Subscriber.first(:conditions => { :username => self.alias_username, :domain => self.alias_domain})
    if (subscriber)
	errors.add( :alias_username, "has already been taken" )
	errors.add( :alias_domain, "has already been taken" )
    end
  end
  
  def generate_alias_db
    if (ALIAS_DB_ENGINE == 'dbtext')
      generate_dbtext()
    end
  end
  
  def generate_dbtext
    dbtext = File.open(DBTEXT_DBALIASES_FILE, "w")
    dbtext.puts("alias_username(str) alias_domain(str) username(str) domain(str)")
    Dbalias.all().each do |dbalias|
      if (dbalias.domain == nil || dbalias.domain == "")
	dbalias.domain = "x"
      end
      if (dbalias.alias_domain == nil || dbalias.alias_domain == "")
	dbalias.alias_domain = "x"
      end		
      if (dbalias.username && dbalias.alias_username)
	dbtext.puts("#{dbalias.alias_username}:#{dbalias.alias_domain}:#{dbalias.username}:#{dbalias.domain}");
      end
    end
    dbtext.close()
  end
end
