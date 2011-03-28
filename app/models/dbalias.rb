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
  validates_uniqueness_of :alias_username, :scope => [:alias_domain, :username, :domain]
  
  validates_presence_of :username
  validates_presence_of :domain, :scope => [:alias_domain, :username, :alias_username]
  
  after_save :generate_alias_db
  after_destroy :generate_alias_db

  belongs_to :subscriber, :validate => true
  
  validate :username_and_domain_must_exist_in_subscriber
  validate :username_and_domain_not_equal_their_aliases
  
  private

  def username_and_domain_not_equal_their_aliases
    if (self.username == self.alias_username && self.domain == self.alias_domain)
      errors.add( :username, "equals Alias Username" )
      errors.add( :domain, "equals Alias Domain" )
    end
  end
  
  def username_and_domain_must_exist_in_subscriber
    subscriber = Subscriber.find_by_username(self.username)
    if (! subscriber)
	errors.add( :username, "not found" )
    elsif (subscriber.domain != self.domain)
	errors.add( :domain, " not found for subscriber \"#{self.username}\"" )
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
