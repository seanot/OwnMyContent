require 'spec_helper'

describe 'Feed' do

  it 'should have link to see your feeds' do
    visit root_path
    click_link 'Sign in with Dropbox'
    visit '/feeds/new'

    expect(page).to have_link('see your feeds')
  end

  it 'should have link to sign out' do
    visit '/auth/dropbox_oauth2'
    visit '/feeds/new'

    expect(page).to have_link('Sign out')
  end



  # it 'has a text box for entry of url' do
  #   visit '/feeds/new'

  #   expect(page).to have
  # end

  # describe 'the download process', type: :feature do
  #   context 'with valid url entered' do
  #     it 'should contain a valid url' do
  #       visit '/feeds/new'
  #       visit feeds_path
  #       enter_rss_feed 'http://podcast.com/feed'

  #       expect(page).to have_content('http://podcast.com/feed')

  #     end

  #   end
  # end

end
