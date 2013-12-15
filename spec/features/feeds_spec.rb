require 'spec_helper'

describe 'Feed' do

  it 'should have link to see your feeds' do
    visit root_path
    click_link 'Sign in with Dropbox'
    visit '/feeds/new'

    expect(page).to have_link('your feeds')
  end

  it 'should have link to sign out' do
    visit '/auth/dropbox_oauth2'
    visit '/feeds/new'

    expect(page).to have_link('sign out')
  end

  context 'entering RSS url' do
    before do
      visit '/feeds/new'
      enter_rss_feed
    end

  end


end
