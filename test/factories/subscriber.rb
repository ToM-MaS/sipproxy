Factory.define :subscriber do |f|
  f.sequence(:username) { |n| "test_username_#{n}" }
  f.sequence(:domain) { |n| "test_domain_#{n}" }
  f.sequence(:password) { |n| "test_password_#{n}" }
  f.sequence(:email_address) { |n| "test_email_address_#{n}" }
  f.sequence(:ha1) { |n| "test_ha1_#{n}" }
  f.sequence(:ha1b) { |n| "test_ha1b_#{n}" }
  f.sequence(:rpid) { |n| "test_rpid_#{n}" }
end
