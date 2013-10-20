class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  require 'dropbox_sdk'
  require 'open-uri'

  include SessionsHelper
  include DropboxHelper
end
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
