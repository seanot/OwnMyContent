class UsersController < ApplicationController

  def index
    p ENV['DROPBOX_APP_KEY']
  end

end
