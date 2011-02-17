class DbaliasesBelongsToSubscribers < ActiveRecord::Migration
  def self.up
    add_column :dbaliases, :subscriber_id, :integer
  end

  def self.down
    remove_column :dbaliases, :subscriber_id
  end
end
