require 'spec_helper'
require 'open-uri'

describe 'DownloadWorker' do

	describe 'full_file' do
		it 'should download the file located at path' do
			worker = DownloadWorker.new
    		worker.stub_chain(:open, :read).and_return('Remote server response')

    		require 'pry'; binding.pry
    		worker.full_file('path').should == "Remote server response"
		end
	end

end