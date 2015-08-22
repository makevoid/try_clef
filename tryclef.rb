require_relative 'config/env'
require_relative 'lib/user_helper'

CLEF_API_BASE   = 'https://clef.io/api/v1'

class TryClef < Sinatra::Base
  configure do
    enable :sessions, :logging
    set :session_secret,  'antanicomesefossesblindafotiprematurata'
    set :clef_api_base,   CLEF_API_BASE
    set :clef_app_id,     CLEF_APP_ID
    set :clef_app_secret, CLEF_APP_SECRET
  end

  helpers LoginHelper

  def generate_state
    state = -> { SecureRandom.urlsafe_base64 32 }
    session[:state] = @state = state.call unless logged_in?
  end

  get '/' do
    generate_state
    haml :index
  end

end

require_relative "routes/login"
require_relative "routes/logout"
