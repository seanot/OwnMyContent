require 'spec_helper'

describe Feed do

  describe "Feed should belong to user" do
    it { should belong_to(:user) }
  end

  describe "Feed should have many enclosures" do
    it { should have_many(:enclosures) }
  end

  describe '#xml' do
    before do
      @user = User.new
      @feed = @user.feeds.create({url: })
    end

    it 'returns a FeedzirraPodcast object'
  end

  describe '#parse_feed!' do

  end
end
