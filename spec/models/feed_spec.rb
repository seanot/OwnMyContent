require 'spec_helper'

describe Feed do

  describe "Feed should belong to user" do
    it { should belong_to(:user) }
  end

  describe "Feed should have many enclosures" do
    it { should have_many(:enclosures) }
  end
end