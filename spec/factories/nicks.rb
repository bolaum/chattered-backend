FactoryGirl.define do
  sequence :name do |n|
    Faker::Internet.user_name + n.to_s
  end

  sequence :name_with_symbols do |n|
    first_name = Faker::Internet.user_name(nil, %w())
    last_name = Faker::Internet.user_name(nil, %w())
    first_name +  %w(. _ -)[n % 3] + last_name + n.to_s
  end

  factory :nick do
    trait :with_symbols do
      name { generate :name_with_symbols }
    end

    name { generate :name }
    status 'online'
  end
end

