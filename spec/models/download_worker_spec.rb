require 'spec_helper'
require 'open-uri'

describe 'DownloadWorker' do

	describe 'full_file' do
	end

	describe '#perform' do
		let(:url) { "http://example.com/podcast.mp3" }
		let(:enclosure) { FactoryGirl.create :enclosure, url: url }

		before do
			# Do not create enclosures for feed
			Feed.any_instance.stub(:parse_feed!) { true }
		end

		context 'given an enclosure exists' do
			it 'attempts to download the enclosure file from the url' do
				worker = DownloadWorker.new

				Faraday.should_receive(:get).with(url)

				worker.perform(enclosure.id)
			end
		end
	
		context 'enclosure with id enclosure_id does not exist' do
			it "should raise an ActiveRecord error" do
				expect{DownloadWorker.new.perform(77)}.to raise_error(ActiveRecord::RecordNotFound)
			end

		end

	end


end