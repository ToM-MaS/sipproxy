class CreateDbaliases < ActiveRecord::Migration
  def self.up
    create_table :dbaliases do |t|
      t.string :alias_username
      t.string :alias_domain
      t.string :username
      t.string :domain

      t.timestamps
    end
  end

  def self.down
    drop_table :dbaliases
  end
end
