class Dbalias < ActiveRecord::Base
  validates_presence_of :alias_username
  validates_uniqueness_of :alias_username, :scope => :username
  
  validates_presence_of :username
  
  after_save :generate_alias_db
  after_destroy :generate_alias_db

  belongs_to :subscriber, :validate => true
  
  private
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
