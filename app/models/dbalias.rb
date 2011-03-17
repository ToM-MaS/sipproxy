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
  validates_uniqueness_of :alias_username
  
  validates_presence_of :username
  
#  validates_presence_of :subscriber_id
#  validates_numericality_of :subscriber_id
  
  after_save :generate_alias_db
  after_destroy :generate_alias_db

  belongs_to :subscriber, :validate => true
  
#  validates_presence_of :subscriber
  
#  validate :username_and_domain_must_be_same_as_in_subscriber
  
  private
  
  def username_and_domain_must_be_same_as_in_subscriber
    if (self.subscriber == nil)
      errors.add( :subscriber_id, "Subscriber #{self.subscriber_id} does not exist." )
    else
      if (self.subscriber.username != self.username)
	errors.add( :username, "Subscriber username \"#{self.subscriber.username}\" differs from alias username (\"#{self.username}\")." ) 
      end
      if (self.subscriber.domain != self.domain)
	errors.add( :domain, "Subscriber domain \"#{self.subscriber.domain}\" differs from alias domain (\"#{self.domain}\")." )
      end
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
