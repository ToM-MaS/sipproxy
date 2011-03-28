Factory.define :dbalias do |f|
  f.sequence(:alias_username) { |n| "dbalias_alias_username_#{n}" }
  f.sequence(:alias_domain) { |n| "dbalias_alias_domain_#{n}" }
  f.sequence(:username) { |n| "dbalias_username_#{n}" }
  f.sequence(:domain) { |n| "dbalias_domain_#{n}" }
end
