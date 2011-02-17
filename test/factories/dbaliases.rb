Factory.define :dbalias do |f|
  f.sequence(:alias_username) { |n| "test_alias_username_#{n}" }
  f.sequence(:alias_domain) { |n| "test_alias_domain_#{n}" }
  f.sequence(:username) { |n| "test_username_#{n}" }
  f.sequence(:domain) { |n| "test_domain_#{n}" }
end
