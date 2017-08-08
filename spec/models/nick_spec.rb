require 'rails_helper'

RSpec.describe Nick, type: :model do
  # Association tests
  # ensure Nick model has a 1:m relationship with the Message model
  it { should have_many(:messages) }
  # ensure Nick model has 1:m relationship with owned Channel model
  it { should have_many(:owned_channels).class_name('Channel') }
  # ensure Nick model has 1:m relationship with joined Channel model
  it { should have_many(:joined_channels).through(:channelJoins) }
end
