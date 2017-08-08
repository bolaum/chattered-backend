FactoryGirl.define do
  sequence :title do |n|
    Faker::Internet.slug + n.to_s
  end

  factory :channel do
    title { generate :title }
    owner_id nil
  end
end
