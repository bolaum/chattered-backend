FactoryGirl.define do
  sequence :sent_at do |n|
    0.minutes.ago - n.seconds
  end
  factory :message do
    content { Faker::Hipster.sentence(1, false, 29) }
    sent_at { generate :sent_at }
    nick_id nil
    channel_id nil
  end
end
