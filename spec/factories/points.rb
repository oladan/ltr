FactoryGirl.define do
  factory :point do
    sequence(:title) {|i| "title #{i}"}
  end
end
