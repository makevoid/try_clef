require_relative 'config/env'

CLEF_API_BASE   = 'https://clef.io/api/v1'

class TryClef < Sinatra::Base
  configure do
    enable :sessions, :logging
    set :session_secret,  'antanicomesefossesblindafotiprematurata'
    set :clef_api_base,   CLEF_API_BASE
    set :clef_app_id,     CLEF_APP_ID
    set :clef_app_secret, CLEF_APP_SECRET
  end

  helpers do
    def generate_state
      SecureRandom.urlsafe_base64 32
    end

    def logged_in?
      current_user
    end

    def current_user
      User.find id: session[:user_id]
    end
  end

  get '/' do
    session[:state] = @state = generate_state unless logged_in?
    haml :index
  end

  get '/logout' do
    session[:user_id] = nil
    redirect "/"
  end
end

require_relative "lib/clef_hook"
