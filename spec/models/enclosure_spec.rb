require 'spec_helper'

describe Enclosure do

  describe "Enclosure should belong to feeds" do
    it { should belong_to(:feed) }
  end


end