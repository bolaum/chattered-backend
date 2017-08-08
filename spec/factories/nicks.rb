FactoryGirl.define do
  factory :nick do
    name { Faker::Internet.user_name }
    token_digest { Nick.digest('notatoken') }
    status { 'online' }
  end
end
