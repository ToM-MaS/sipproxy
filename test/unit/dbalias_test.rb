require 'test_helper'

class DbaliasTest < ActiveSupport::TestCase
  should "be valid build" do
    assert Factory.build(:dbalias).valid?
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
  should "be valid with nil alias_domain" do
    assert Factory.build(:dbalias, :alias_domain => nil).valid?
  end
  should "be valid with nil domain" do
    assert Factory.build(:dbalias, :domain => nil).valid?
  end
  should "not be valid when alias_username not unique" do
    dbalias = Factory.create(:dbalias)
    assert !Factory.build(:dbalias, :alias_username => dbalias.alias_username).valid?
  end   
end
