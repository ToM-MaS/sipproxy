class Subscriber < ActiveRecord::Base
  validates_presence_of :username
  validates_uniqueness_of :username

  after_save :generate_auth_db
  after_destroy :generate_auth_db

  has_many :dbaliases, :order => 'alias_username', :dependent => :destroy
  
  private
  def generate_auth_db
    if (AUTH_DB_ENGINE == 'dbtext')
      generate_dbtext()
    end
  end
  
  def generate_dbtext
    dbtext = File.open(DBTEXT_SUBSCRIBER_FILE, "w")
    dbtext.puts("username(str) domain(str) password(str) email_address(str) datetime_created(int) datetime_modified(int) ha1(str) ha1b(str) rpid(str,null)")
    Subscriber.all().each do |subscriber|
      if (subscriber.domain == "")
	subscriber.domain = "x"
      end
      if (subscriber.password == "")
	subscriber.password = "x"
      end
      if (subscriber.email_address == "")
	subscriber.email_address = "x"
      end
      if (subscriber.ha1 == "")
	subscriber.ha1 = "x"
      end		
      if (subscriber.ha1b == "")
	subscriber.ha1b = "x"
      end			
      if (subscriber.username)
	dbtext.puts("#{subscriber.username}:#{subscriber.domain}:#{subscriber.password}:#{subscriber.email_address}:#{subscriber.created_at.to_i}:#{subscriber.updated_at.to_i}:#{subscriber.ha1}:#{subscriber.ha1b}::");
      end
    end
    dbtext.close()
  end	
end
