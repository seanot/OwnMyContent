require 'spec_helper'

describe User do

  describe "User model should have many feeds" do
    it { should have_many(:feeds) }
  end


end
