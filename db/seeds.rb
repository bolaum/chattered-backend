# create first user
roland = Nick.create!(name: 'roland', status: 'online')

# create second user
jake = Nick.create!(name: 'jake', status: 'online')

# create 8 more users
random_users = []
20.times do |n|
  name = Faker::Internet.user_name
  status = 'online'

  random_users << Nick.create!(name: name, status: status)
end

# create 2 channels and join them
c1 = roland.owned_channels.create!(title: 'Ka-tet')
c2 = roland.owned_channels.create!(title: 'Hambry')
roland.joined_channels << c1 << c2
jake.joined_channels << c1 << c2

# create 50 channels
50.times do |n|
  c = jake.owned_channels.create!(title: Faker::Lovecraft.location.parameterize + n.to_s)
  jake.joined_channels << c
end
Faker::Lovecraft.location

# make all other users join second channel
random_users.each do |n|
  n.joined_channels << c2
end

# all users create 5 messages to all joined channel
5.times do |n|
  skew = 0.seconds
  Nick.all.each do |user|
    user.joined_channels.each do |channel|
      content = Faker::Hipster.sentence(1, false, 29)
      sent_at = n.minutes.ago - skew
      user.messages.create!(content: content, sent_at: sent_at, channel: channel)
      skew += 1.seconds
    end
  end
end
