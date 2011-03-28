require 'test_helper'

class DbaliasTest < ActiveSupport::TestCase
  should "be valid build" do
    subscriber = Factory.create(:subscriber)
    assert Factory.build(:dbalias, :username => subscriber.username, :domain => subscriber.domain).valid?
  end
  should "not be valid with .new" do
    assert !Dbalias.new.valid?
  end
  should "not be valid with nil alias_username" do
    assert !Factory.build(:dbalias, :alias_username => nil).valid?
  end
  should "not be valid with nil username" do
    assert !Factory.build(:dbalias, :username => nil).valid?
  end
  should "not be valid with nil alias_domain" do
    assert !Factory.build(:dbalias, :alias_domain => nil).valid?
  end
  should "not be valid with nil domain" do
    assert !Factory.build(:dbalias, :domain => nil).valid?
  end
  should "not be valid with username and domain alias_username and alias_domain" do
    assert !Factory.build(:dbalias, :username => 'test_user', :domain => 'test_domain', :alias_username => 'test_user', :alias_domain => 'test_domain').valid?
  end
  should "not be valid if not unique" do
    subscriber = Factory.create(:subscriber)
    dbalias = Factory.create(:dbalias, :username => subscriber.username, :domain => subscriber.domain)
    assert !Factory.build(:dbalias, :username => dbalias.username, :domain => dbalias.domain, :alias_username => dbalias.alias_username, :alias_domain => dbalias.alias_domain).valid?
  end

end
