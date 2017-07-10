FactoryGirl.define do
  factory :todo do
    sequence(:title) { |n| "todo#{n}" }
    completed false
  end
end
