# create first user
roland = Nick.create!(name: 'roland', token_digest: Nick.digest('123456'), status: 'online')

# create second user
jake = Nick.create!(name: 'jake', token_digest: Nick.digest('123456'), status: 'online')

# create 8 more users
random_users = []
8.times do |n|
  name = Faker::Internet.user_name
  token_digest = Nick.digest(Faker::Internet.password)
  status = 'online'

  random_users << Nick.create!(name: name, token_digest: token_digest, status: status)
end

# create 2 channels and join them
c1 = roland.owned_channels.create!(title: 'Ka-tet')
c2 = roland.owned_channels.create!(title: 'Hambry')
roland.joined_channels << c1 << c2
jake.joined_channels << c1 << c2

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
