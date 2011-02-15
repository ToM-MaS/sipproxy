class CreateSubscribers < ActiveRecord::Migration
  def self.up
    create_table :subscribers do |t|
      t.string :username
      t.string :domain
      t.string :password
      t.string :email_address
      t.string :ha1
      t.string :ha1b
      t.string :rpid

      t.timestamps
    end
  end

  def self.down
    drop_table :subscribers
  end
end
