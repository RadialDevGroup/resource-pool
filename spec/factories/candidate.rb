FactoryGirl.define do
  factory :candidate do
    sequence(:name) { |n| "candidate #{n}" }
    sequence(:email) { |n| "candidate-email-#{n}@example.com" }
    sequence(:telephone) { |n| "702 555-#{n.to_s.rjust(4,'5')}" }
    sequence(:linkedin) { |n| "http://linkedin/#{n}-user" }
    sequence(:twitter) { |n| "http://twitter/user#{n}" }
    candidacy 'new'
  end
end
