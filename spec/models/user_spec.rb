require 'spec_helper'

describe User do

  describe "User model should have many feeds" do
    it { should have_many(:feeds) }
  end

  describe '#server_path' do
    before do
      @user = User.create
    end

    it "returns the user's path in the public folder" do
      expect(@user.server_path).to eq("public/user_content/#{@user.id}")
    end
  end


end
